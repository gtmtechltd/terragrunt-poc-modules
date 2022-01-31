# base module

This is dummy placeholder and should be intentionally empty. It is not a feature module, but is
an empty placeholder to satisfy needing a `terraform{ source= }` block in your terragrunt
config.

In the POC, module calls are dynamically written by the HCL code, as opposed to normal
terragrunt deployments where a single `terraform{ source= }` blcok specifies the module
to implement.

It is used like this within terragrunt:

```
terraform {
  source = "git::github.com/gtmtechltd/gtest-modules//base?ref=v1.0.0"
}
```

It uses a config map which must be defined somewhere within the terragrunt.hcl stack

```
inputs = {
  config = {}
}
```

The base module doesn't actually do anything itself.

