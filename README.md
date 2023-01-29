# Terragrunt demo

This is a demo using [terraform](https://www.terraform.io) with [terragrunt](https://github.com/gruntwork-io/terragrunt).

<!-- TOC -->
* [Terragrunt demo](#terragrunt-demo)
  * [Features](#features)
    * [Other features not in demo](#other-features-not-in-demo)
  * [Get started](#get-started)
    * [Install repository tools](#install-repository-tools)
    * [Local environment (Localstack)](#local-environment--localstack-)
    * [Cleanup](#cleanup)
<!-- TOC -->

## Features

* Terragrunt basic features
  * dependencies
  * file generation
  * include
  * build-in functions
  * local & remote sources (almost the same as terraform)
  * multi-account
  * encryption
  * hooks

### Other features not in demo

* Caching

## Repository structure

```
├── 1-basics
├── 2-features
│     ├── dependencies
│     ├── functions
│     ├── generate
│     ├── inheritance
│     ├── sources
├── 3-features
│     ├── aws
│     ├── functions
│     ├── hooks
├── 4-features
│     └── encryption
├── 5-simple
├── 6-intermediate
├── 7-advanced
├── modules
│     └── s3-bucket
├── other
│     ├── Makefile
│     ├── providers.tf
│     └── taskfile.yml
├── Brewfile                    # System packages
├── activate.sh                 # Activate virtual environment
├── docker-compose.yaml         # Run localstack using docker
├── requirements.txt            # Python packages
```

## Get started

### Install repository tools

```bash
brew bundle install
python -m venv ./.env && source ./.env/bin/activate
pip install -r requirements.txt
```

### Local environment (Localstack)

```shell
# pip install localstack
docker compose up -d
```

> #### In other repositories  
> Dynamically generate the provider like in this demo or 
> run the following command to redirect `terraform` command to `terraform-local:
> ```bash
> function terraform() { tflocal "$@" }
> ```

### Cleanup

```bash
docker compose down
```
