locals {
  names          = [ for e in var.org_accounts : e["name"] if e["status"] == "ACTIVE" && substr(e["name"], -(length(var.environment)), -1) == var.environment ]
  ids            = [ for e in var.org_accounts : e["id"]   if e["status"] == "ACTIVE" && substr(e["name"], -(length(var.environment)), -1) == var.environment ]
  bucket_paths   = formatlist("${local.s3_bucket_arn}/%s/AWSLogs/%s/*", local.names, local.ids)
}

data "aws_iam_policy_document" "cloudtrail_s3_bucket" {
  statement {
    sid       = "AWSCloudTrailAclCheck"
    effect    = "Allow"
    resources = [ aws_s3_bucket.cloudtrail.arn ]
    actions   = [ "s3:GetBucketAcl" ]

    principals {
      type        = "Service"
      identifiers = [ "cloudtrail.amazonaws.com" ]
    }
  }

  statement {
    sid       = "AWSCloudTrailWrite"
    effect    = "Allow"
    resources = local.bucket_paths
    actions   = [ "s3:PutObject" ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = [ "bucket-owner-full-control" ]
    }

    principals {
      type        = "Service"
      identifiers = [ "cloudtrail.amazonaws.com" ]
    }
  }

  provider = aws.security-admin-us-east-1
}
