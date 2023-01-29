terragrunt_version_constraint = "~> 0.38"
# terraform_binary            = local.terraform_binary
prevent_destroy               = false
skip                          = false
# viam_role                   = "iam_role = "arn:aws:iam::ACCOUNT_ID:role/ROLE_NAME"
# iam_assume_role_duration    = 14400
# iam_assume_role_session_name = "terragrunt"
retry_max_attempts            = 2
retry_sleep_interval_sec      = 10
retryable_errors              = [
  "(?s).*timeout while waiting for plugin to start.*",
  "(?s).*Failed to install provider from shared cache.*",
  "(?s).*Failed to download module.*"
]


locals {
  run_cmd = run_cmd("echo", "hello")
  bucket = get_env("BUCKET", "default_name")
  config = "${get_repo_root()}/config/strawberries.conf"
  aws_account_id = get_aws_account_id()
  aws_caller_identity_arn = get_aws_caller_identity_arn()
  aws_caller_user_id = get_aws_caller_identity_user_id()
}

terragrunt {
  extra_arguments "do_backup" {
    commands  = ["apply"]
    arguments = ["-backup=${local.files.backup}"]
  }

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


}
