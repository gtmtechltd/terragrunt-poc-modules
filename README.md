# terragrunt-poc-modules

Modules for the terragrunt-poc

There are 2 types of modules in this repo, modules and multimodules.

* **Modules** apply some simple generic config to each account specified in the terragrunt feature config:

```
locals {
  account_groups = {
    all = {
      account_filter_regex = ".*",
      source               = "git@github.com:gtmtechltd/terragrunt-poc-modules//example?ref=v1.0.0",
      ...
    }
  }
}
```

* **Multimodules** apply different config to subselection of accounts, and other config to another subselection of accounts. Dependencies between each are possible generating a staged setup for each of the components.

```
locals {
  account_groups = {
    audit_accounts = {
      account_filter_regex = "audit-.*"
      source               = "git@github.com:gtmtechltd/gtest-modules//my_feature/audit?ref=v1.0.0"
      ...
    }
    network_accounts = {
      account_filter_regex = "network-.*"
      source               = "git@github.com:gtmtechltd/gtest-modules//my_feature/network?ref=v1.0.0"
    }
    ...
  }
}
```

You can refer to the `README.md` in each of the below modules and multimodules to learn how to set them up.

## Modules

* simple-iam-role : a simple feature module to put an IAM role in every account specified
* base            : an empty module used as the terragrunt source

## Multimodules

* cloudtrail ( account_groups: _master_, _tenant_, _audit_ )
