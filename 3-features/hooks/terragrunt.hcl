
terragrunt_version_constraint = "~> 0.38"
retry_max_attempts            = 2
retry_sleep_interval_sec      = 10
retryable_errors              = [
  "(?s).*timeout while waiting for plugin to start.*",
  "(?s).*Failed to install provider from shared cache.*",
  "(?s).*Failed to download module.*"
]


# ignore for now
include "root" {
  path = find_in_parent_folders()
}

locals {
  cmds = {
    retry         = join(" ", concat(["terraform"], get_terraform_cli_args()))
    output_change = ["apply", "import", "destroy"]
    state_change  = compact([
      "apply", "import", "destroy",
      length(setintersection(["list", "pull"], get_terraform_cli_args())) >= 1 ? "" : "state"
    ])
  }



  files       = {
    plan    = "${get_original_terragrunt_dir()}/outputs/tfplan"
    backup  = "${get_original_terragrunt_dir()}/outputs/tfstate.backup"
    costs   = "${get_original_terragrunt_dir()}/outputs/infracost"
    outputs = "${get_original_terragrunt_dir()}/outputs/outputs.tfvars"
  }
  formats = {
    plan   = ["json", "txt"]    # txt, json
    costs  = ["json", "github", "diff", "table", "html"] # diff, table, html, github, gitlab, azure-repos, bitbucket, slack
    graphs = ["module", "dependencies"]
  }
  exists = {
    plan       = fileexists("${local.files.plan}")
    plan        = fileexists("${local.files.plan}")
    costs       = fileexists("${local.files.costs}.json")
  }
}


terraform {

  extra_arguments "tfvars" {
    commands           = [get_terraform_command()]
    required_var_files = []
    optional_var_files = [
      find_in_parent_folders("account.tfvars", "account.tfvars"),
      find_in_parent_folders("env.tfvars", "env.tfvars"),
      find_in_parent_folders("region.tfvars", "region.tfvars"),
      find_in_parent_folders("stack.tfvars", "stack.tfvars")
    ]
  }

  extra_arguments "retry_locked" {
    commands  = get_terraform_commands_that_need_locking()
    arguments = ["-lock-timeout=5m"]
  }
  extra_arguments "parallelism" {
    commands  = get_terraform_commands_that_need_parallelism()
    arguments = ["-parallelism=5"]
  }
  extra_arguments "save_plan" {
    commands  = ["plan"]
    arguments = ["-input=false", "-out=${local.files.plan}"] # "-lock=false",
  }
  extra_arguments "do_backup" {
    commands  = ["apply"]
    arguments = ["-backup=${local.files.backup}"]
  }
  extra_arguments "for_graph" {
    commands  = ["graph"]
    arguments = fileexists("${local.files.plan}") ? ["-plan=${local.files.plan}"] : []
  }


  after_hook "plan_formats" {
    commands = ["plan"]
    execute  = ["sh", "-c", join(" && ", compact(concat([
      "terraform show -no-color -json ${local.files.plan} | jq -r '.' > ${local.files.plan}.json",
      contains(local.formats.plan, "txt")    ? "terraform show -no-color ${local.files.plan} > ${local.files.plan}.txt" : ""
    ])))]
  }
  after_hook "plan_graphs" {
    commands = ["plan"]
    execute  = ["sh", "-c", join(" && ", compact(concat([
      contains(local.formats.graphs, "module") ? "terraform graph -draw-cycles -plan=${local.files.plan} > ${local.files.plan}.dot" : ""
    ])))]
  }
  after_hook "plan_graphs" {
    commands = ["plan"]
    execute  = ["sh", "-c", join(" && ", compact(concat([
      contains(local.formats.graphs, "module") ? "terraform graph -draw-cycles -plan=${local.files.plan} | dot -Tpng > ${local.files.plan}.png" : ""
    ])))]
  }
  after_hook "docs" {
    commands = ["apply"]
    execute  = ["sh", "-c", join(" && ", compact(concat([
      "terraform-docs markdown table --output-file README.md --output-mode inject ."
    ])))]
  }
  after_hook "plan_costs" {
    commands =["plan"] # "plan"
    execute  = ["sh", "-c", join(" && ", compact(concat(
      [length(local.formats.costs) >= 1  ? "infracost breakdown --path ${local.files.plan}.json --format json | jq -r '.' > ${local.files.costs}.json" : ""],
      formatlist("infracost output --show-skipped --path ${local.files.costs}.json --format %s > ${local.files.costs}.%s",
          matchkeys([
            "table", "html", "github-comment", "gitlab-comment", "azure-repos-comment", "bitbucket-comment",
            "slack-message"
          ], [
            "table", "html", "github", "gitlab", "azure-repos", "bitbucket", "slack"
          ], setsubtract(local.formats.costs, ["json", "diff"])),
          matchkeys(["txt", "html", "md", "md", "md", "md", "slack.json"], [
            "table", "html", "github", "gitlab", "azure-repos", "bitbucket", "slack"
          ], setsubtract(local.formats.costs, ["json", "diff"]))
      ),
      ["open ./outputs/infracost.html"]
      )))
    ]
  }

  after_hook "clean" {
    commands = anytrue([(get_platform() == "windows"), (!local.exists.plan)]) ? [] : local.cmds.state_change
    execute  = [
      "sh", "-c", join(" ", [
        local.exists.plan ? "rm ${local.files.plan}*" : ""
      ])
    ]
  }

  after_hook "outputs" {
    commands = (get_platform() == "windows") ? [] : local.cmds.output_change
    execute  = [
      "sh", "-c", join(" && ", [
        "mkdir -p ${dirname(local.files.outputs)}",
        "terraform output -no-color > ${local.files.outputs}"
      ])
    ]
  }

  error_hook "reinit" {
    commands  = (get_terraform_command() == "init" || get_platform() == "windows") ? [] : [get_terraform_command()]
    execute   = ["sh", "-c", join(";\n", ["terraform init", local.cmds.retry])]
    on_errors = ["(?s).*Required plugins are not installed.*"]
  }
}
