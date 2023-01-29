


locals {
  # ?ref=v0.0.1"
  base_source_url = "git::ssh://git@github.com/JeanMGirard/terragrunt-demo.git//modules/s3-bucket"
}

terraform {
  source = "${local.base_source_url}"
}

inputs = {
  bucket_name = "my-bucket-dev"
}
