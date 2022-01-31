locals {
  cloudtrail_name = format("my-cloudtrail-%s", var.environment )
}

resource "aws_cloudtrail" "secops" {
  name                          = local.cloudtrail_name
  enable_logging                = true
  s3_bucket_name                = var.cloudtrail_bucket_name
  s3_key_prefix                 = var.account_name
  include_global_service_events = true
  is_multi_region_trail         = true
  is_organization_trail         = false
  tags                          = merge(jsondecode(var.config["global_tags"]), {
    "Name"        = "cloudtrail-secops global",
    "Id"          = "cloudtrail-secops",
    "Environment" = var.environment
  })

  provider = aws.security-admin-us-east-1
}
