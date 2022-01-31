# simple-iam-role (module)

POC demo of a simple module to create a simple IAM role in every AWS account for which this module is called.

## Usage:

To use this, reference it in `config.hcl` within your terragrunt feature.

Example:

```
locals {
  account_groups = {
    all = {
      account_filter_regex = ".*",
      source               = "git::git@github.com:gtmtechltd/terragrunt-poc-modules//features/simple-iam-role?ref=v1.0.0",
      providers            = {
        "security-admin"   = {
          "path"    = "my-security-admin-role",
          "regions" = [ "us-east-1" ]
        }
      },
      variables            = {}
    }
  }
}
```

This creates the following resources in every account specified:

* some_test_role (IAM role)
