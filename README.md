# Terragrunt demo

This is a demo using [terraform](https://www.terraform.io) with [terragrunt](https://github.com/gruntwork-io/terragrunt).


## Install repository tools

```bash
brew bundle install
python -m venv ./.env && source ./.env/bin/activate
pip install -r requirements.txt
```

### Local environment using Localstack

```shell
# pip install localstack
docker compose up
```

Run the following command to redirect `terraform` command to `terraform-local:

```bash
function terraform() { tflocal "$@" }
```
