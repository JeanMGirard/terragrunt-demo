# Dependencies

```bash
terragrunt graph-dependencies | dot -Tpng > dependencies.png
terragrunt run-all plan
terragrunt run-all apply
terragrunt run-all destroy
```

- The module 1 has no dependency
- The module 2 depends on module 1
- The module 3 must be build after module 1 but do not need its outputs
- The module 4 depends on module 1, 2 and 3



