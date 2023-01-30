
# ignore for now
include "root" {
  path = find_in_parent_folders()
}


dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    arn = ""
    name = ""
  }
}

inputs = {
  vpc_name = dependency.vpc.outputs.name
}



