


locals {
  base_source_url     = find_in_parent_folders("modules/s3-bucket")
}

terraform {
  source = "${local.base_source_url}"
}

inputs = {
  bucket_name = "my-bucket-dev"
}
