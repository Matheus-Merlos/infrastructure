resource "aws_iam_user" "ecr_user" {
  name = "ecr_user"

  lifecycle {
    ignore_changes = [ tags ]
  }
}

data "aws_iam_policy_document" "ecs_user_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:BatchGetImage",
      "ecr:UploadLayerPart",
      "ecr:CreateRepository",
      "ecr:DescribeRepositories",
      "ecs:RegisterTaskDefinition",
      "ecs:DescribeTaskDefinition",
      "ecs:ListTaskDefinitions",
      "elasticfilesystem:DescribeFileSystems",
      "elasticfilesystem:DescribeAccessPoints"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "ecs_user_policy" {
  name   = "ECSImageUserPolicy"
  policy = data.aws_iam_policy_document.ecs_user_policy.json
}

resource "aws_iam_user_policy_attachment" "ecr_user_policy_attachment" {
  user       = aws_iam_user.ecr_user.name
  policy_arn = aws_iam_policy.ecs_user_policy.arn
}

resource "aws_iam_access_key" "ecr_access_key" {
  user = aws_iam_user.ecr_user.name
}



output "ecr_user_access_key_id" {
  value = aws_iam_access_key.ecr_access_key.id
}

output "ecr_user_secret_access_key" {
  value     = aws_iam_access_key.ecr_access_key.secret
  sensitive = true
}
