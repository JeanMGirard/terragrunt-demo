
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
dependency "module_2" {
  config_path = "../module-2"
  mock_outputs = {
    s3_bucket_arn = ""
  }
}
dependency "module_3" {
  config_path = "../module-3"
  mock_outputs = {
    s3_bucket_arn = ""
  }
}

inputs = {
  bucket_1 = dependency.module_1.outputs.s3_bucket_arn
  bucket_2 = dependency.module_2.outputs.s3_bucket_arn
  bucket_3 = dependency.module_3.outputs.s3_bucket_arn
}

