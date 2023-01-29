
# ignore for now
include "root" {
  path = find_in_parent_folders()
}


dependency "module_1" {
  config_path = "../module-1"
  mock_outputs = {
    s3_bucket_arn = ""
  }
}

inputs = {
  bucket_name = join("-", [dependency.module_1.outputs.s3_bucket_arn, "-logs"])
}



