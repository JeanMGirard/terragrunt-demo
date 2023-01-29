include "common" {
  path = find_in_parent_folders("common.hcl")
  expose = true
}
include "root" {
  path = find_in_parent_folders("_env/_account/_app/api.hcl")
  expose = true
}

# iam_role = "arn:aws:iam::${include.common.inputs.account}:role/ROLE_NAME"


terraform {
  source = "${include.root.locals.source_base_url}"
}

inputs = {
  bucket_name = "bucket-${include.common.inputs.account}"
}
