# Dependencies

```bash
terragrunt run-all plan
```


<br/>

#### Includes those that include a file

```bash
# Includes the ones module-2 depends on
terragrunt run-all \
  --terragrunt-modules-that-include ./prod/terragrunt.hcl \
  apply
```
