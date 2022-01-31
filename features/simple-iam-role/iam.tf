resource "aws_iam_role" "some_simple_role" {
  name = "some_simple_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "EC2CanAssume"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  provider = aws.security-admin-us-east-1
}

