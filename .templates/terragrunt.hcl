terragrunt_version_constraint = "~> 0.38"
# terraform_binary              = local.terraform_binary
#viam_role                      = "arn:aws:iam::254799134572:role/terraform"
retry_max_attempts            = 2
retry_sleep_interval_sec      = 10
retryable_errors              = [
  "(?s).*timeout while waiting for plugin to start.*",
  "(?s).*Failed to install provider from shared cache.*",
  "(?s).*Failed to download module.*"
]



remote_state {
  backend  = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket  = "artifacts.devops.jeanmgirard.com"
    key     = "tfstates/1-basics/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}



