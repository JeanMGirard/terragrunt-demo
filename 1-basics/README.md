# Basics

### terragrunt.hcl

Your ``terragrunt.hcl`` file is the entry point for terragrunt

* it can be in the same directory
* it can be in another directory as long as the ``source`` is specified

### run-all

```bash
# export TERRAGRUNT_WORKING_DIR="$(pwd)/live"
terragrunt run-all --terragrunt-working-dir="$(pwd)/live" plan
```
