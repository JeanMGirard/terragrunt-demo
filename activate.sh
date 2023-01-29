#!/usr/bin/env bash
# shellcheck disable=SC2120
# shellcheck disable=SC2128

SCRIPT_DIR="$(git rev-parse --show-toplevel)";

export TERRAGRUNT_DOWNLOAD="$SCRIPT_DIR/.terragrunt-cache"
export TF_PLUGIN_CACHE_DIR="$SCRIPT_DIR/.terraform.d/plugin-cache"
mkdir -p "$TERRAGRUNT_DOWNLOAD" "$TF_PLUGIN_CACHE_DIR"

alias tg="terragrunt"
alias tg-run="terragrunt run-all --terragrunt-ignore-dependency-errors"
alias tg-run-only="terragrunt run-all --terragrunt-ignore-external-dependencies --terragrunt-ignore-dependency-errors"
alias tg-graph="terragrunt graph-dependencies --terragrunt-include-external-dependencies"




tg::map-deps-img(){
	terragrunt graph-dependencies --terragrunt-include-external-dependencies $@ | dot -Tpng > "$(tg::workdir)/dependencies.png";
}
tg::map-infra-img(){
	terragrunt state pull | inframap generate | dot -Tpng > "$(tg::workdir)/inframap.png";
}

infracost auth login
