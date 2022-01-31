data "aws_organizations_organization" "this" {
  provider = aws.org-viewer-us-east-1
}
