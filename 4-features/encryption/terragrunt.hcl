


locals {
  secret_vars = yamldecode(sops_decrypt_file("config/secrets.enc.yaml"))
}

inputs = merge(
  local.secret_vars,
  {
    # additional inputs
  }
)
