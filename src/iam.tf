/*
User to run terraform in GitHub Actions
*/
resource "aws_iam_user" "dns_checker" {
  name = "dns-checker"

  lifecycle {
    ignore_changes = [tags]
  }
}

data "aws_iam_policy_document" "dns_checker_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:Get*"
    ]
    resources = [
      "arn:aws:s3:::azure-infrastructure-terraform-remote-state",
      "arn:aws:s3:::azure-infrastructure-terraform-remote-state/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:Describe*",
      "ec2:List*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "dns_checker_policy" {
  name   = "DNSChecker"
  policy = data.aws_iam_policy_document.dns_checker_policy.json
}

resource "aws_iam_user_policy_attachment" "dns_checker_attachment" {
  user       = aws_iam_user.dns_checker.name
  policy_arn = aws_iam_policy.dns_checker_policy.arn
}





resource "aws_iam_user" "image_upload" {
  name = "image-upload"

  lifecycle {
    ignore_changes = [tags]
  }
}

data "aws_iam_policy_document" "image_upload_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:PutObjectAcl",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::neon-bot-images",
      "arn:aws:s3:::neon-bot-images/*"
    ]
  }
}

resource "aws_iam_policy" "image_upload_policy" {
  name   = "S3ImageBucketUpload"
  policy = data.aws_iam_policy_document.image_upload_policy.json
}

resource "aws_iam_user_policy_attachment" "image_upload_policy_attachment" {
  user       = aws_iam_user.image_upload.name
  policy_arn = aws_iam_policy.image_upload_policy.arn
}







resource "aws_iam_user" "fds_terraform_backend_user" {
  name = "FDSTerraformBackend"

  lifecycle {
    ignore_changes = [tags]
  }
}

data "aws_iam_policy_document" "fds_terraform_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:Get*"
    ]
    resources = [
      "arn:aws:s3:::fds-terraform-state",
      "arn:aws:s3:::fds-terraform-state/*"
    ]
  }
}

resource "aws_iam_policy" "fds_terraform_policy" {
  name   = "FDSTerraformPolicy"
  policy = data.aws_iam_policy_document.fds_terraform_policy.json
}

resource "aws_iam_user_policy_attachment" "fds_terraform_attachment" {
  user       = aws_iam_user.fds_terraform_backend_user.name
  policy_arn = aws_iam_policy.fds_terraform_policy.arn
}

resource "aws_iam_access_key" "fds_terraform_access_key" {
  user = aws_iam_user.fds_terraform_backend_user.name
}


output "fds_terraform_access_key_id" {
  value = aws_iam_access_key.fds_terraform_access_key.id
}

output "fds_terraform_secret_access_key" {
  value     = aws_iam_access_key.fds_terraform_access_key.secret
  sensitive = true
}





resource "aws_iam_user" "neon_user" {
  name = "user-neon"

  lifecycle {
    ignore_changes = [tags]
  }
}

data "aws_iam_policy_document" "neon_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::neon-bot-database-dumps",
      "arn:aws:s3:::neon-bot-database-dumps/*"
    ]
  }
}

resource "aws_iam_policy" "neon_policy" {
  name   = "NeonPolicy"
  policy = data.aws_iam_policy_document.neon_policy.json
}

resource "aws_iam_user_policy_attachment" "neon_attachment" {
  user       = aws_iam_user.neon_user.name
  policy_arn = aws_iam_policy.neon_policy.arn
}

resource "aws_iam_access_key" "neon_access_key" {
  user = aws_iam_user.neon_user.name
}


output "neon_access_key_id" {
  value = aws_iam_access_key.neon_access_key.id
}

output "neon_secret_access_key" {
  value     = aws_iam_access_key.neon_access_key.secret
  sensitive = true
}
