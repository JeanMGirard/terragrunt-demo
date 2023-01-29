



inputs = {
  paths = {
    get_repo_root    = "${get_repo_root()} (/modules/s3-bucket)"
    find_in_parent_folders     = find_in_parent_folders("modules/s3-bucket")
    get_path_to_repo_root = "${get_path_to_repo_root()} (/modules/s3-bucket)"
    get_original_terragrunt_dir = get_original_terragrunt_dir()
    get_parent_terragrunt_dir = "(skipped) get_parent_terragrunt_dir"
  }
}

terraform {
  source = "./module"
}

