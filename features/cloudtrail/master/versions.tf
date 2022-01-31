terraform {
  required_providers {
    aws = {
      configuration_aliases = [ aws.org-viewer-us-east-1 ]
      source  = "hashicorp/aws"
      version = "~> 3.70.0"
    }
  }
  required_version   = "~> 1.1.3"
}

