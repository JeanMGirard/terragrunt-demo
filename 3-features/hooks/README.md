# Hooks


```hcl
terragrunt {
  before_hook "say_hi" {
    commands = ["plan"]
    execute  = ["echo 'hello friend'"]
  }
  after_hook "say_bye" {
    commands = ["plan"]
    execute  = ["echo 'bye friend'"]
  }
}
```

 ### Test it

```bash
terragrunt plan
open ./outputs/infracost.html


terragrunt apply -auto-approve
```

**The docs below will update!**


==========================================

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.52.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|

## Outputs

| Name | Description |
|------|-------------|
<!-- END_TF_DOCS -->

