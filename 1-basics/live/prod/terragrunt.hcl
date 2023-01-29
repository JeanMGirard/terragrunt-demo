


locals {
  base_source_url     = find_in_parent_folders("module")
}

terraform {
  source = "${local.base_source_url}"
}

inputs = {
  bucket_name = "my-bucket-prod"
}
