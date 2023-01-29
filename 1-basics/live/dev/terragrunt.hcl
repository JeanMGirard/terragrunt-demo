


locals {
  base_source_url     = "../module"
}

terraform {
  source = "${local.base_source_url}"
}

inputs = {
  bucket_name = "my-bucket-dev"
}
