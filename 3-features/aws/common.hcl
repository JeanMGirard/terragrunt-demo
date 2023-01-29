

locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl", "not-found"), { inputs = {} })
  env_vars     = read_terragrunt_config(find_in_parent_folders("env.hcl", "not-found"), { inputs = {} })
  app_vars     = read_terragrunt_config(find_in_parent_folders("app.hcl", "not-found"), { inputs = {} })

  parts     = try(split("/", try(split("aws/", get_original_terragrunt_dir())[1], "")), [])


  meta = merge(
    {
      env       = local.parts[0]
      account   = local.parts[1]
      app       = reverse(local.parts)[0]
    },
    {for k, v in try(local.account_vars["inputs"], {}) : k => v if (v != null && v != "")},
    {for k, v in try(local.env_vars["inputs"], {}) : k => v if (v != null && v != "")},
    {for k, v in try(local.app_vars["inputs"], {}) : k => v if (v != null && v != "")}
  )
  env = lookup(local.meta, "env", "dev")
  account = lookup(local.meta, "account", "dev")
  app = lookup(local.meta, "app", "dev")
}


inputs = merge(
  local.meta,
  {
    meta         = local.meta
  }
)
