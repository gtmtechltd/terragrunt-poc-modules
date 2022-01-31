# cloudtrail multimodule

POC demo of a multi-part cloudtrail feature involving cross-account coordination

To use this, reference it in `config.hcl` in your feature.

Example:

```
locals {
  account_groups = {
    master = {
      account_filter_regex = "master",
      source               = "git::git@github.com:gtmtechltd/terragrunt-poc-modules//features/cloudtrail/master?ref=v1.0.0",
      providers            = {
        "org-viewer"       = {
          "path"    = "my-org-admin-role",
          "regions" = [ "us-east-1" ]
        }
      },
      variables            = {
        "environment" = "\"master\""
      }
    },
    audit-dev = {
      account_filter_regex = "audit-dev",
      source               = "git::git@github.com:gtmtechltd/terragrunt-poc-modules//features/cloudtrail/audit?ref=v1.0.0",
      providers            = {
        "security-admin" = {
          "path"    = "my-security-admin-role",
          "regions" = [ "us-east-1" ]
        }
      },
      variables            = {
        "environment"  = "\"dev\""
        "org_accounts" = "module.master.accounts"
      }
    },
    res-dev = {
      account_filter_regex = "tenant-.*-dev",
      source               = "git::git@github.com:gtmtechltd/terragrunt-poc-modules//features/cloudtrail/tenant?ref=v1.0.0",
      providers            = {
        "security-admin" = {
          "path"    = "my-security-admin-role",
          "regions" = [ "us-east-1" ]
        }
      },
      variables            = {
        "environment"            = "\"dev\""
        "cloudtrail_bucket_name" = "module.audit-dev.cloudtrail_bucket_name"
      }
    }
  }
}
```

This creates the following resources:

* In a master account
  * An org datasource for viewing the org structure
* In each shared-audit account in the dev environment
  * An S3 Bucket
  * An S3 Bucket Policy
  * An S3 Bucket Public Access Block
* In each resident account in the dev environment
  * A Cloudtrail pointing to the S3 Bucket in the corresponding shared-audit account
