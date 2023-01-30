
# ignore for now
include "root" {
  path = find_in_parent_folders()
}


dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    name = ""
  }
}
dependency "redis" {
  config_path = "../redis"
  mock_outputs = {
    arn = ""
  }
}
dependency "mysql" {
  config_path = "../mysql"
  mock_outputs = {
    arn = ""
  }
}

inputs = {
  vpc_name = dependency.vpc.outputs.name
  redis_arn = dependency.redis.outputs.arn
  mysql_arn = dependency.mysql.outputs.arn
}

