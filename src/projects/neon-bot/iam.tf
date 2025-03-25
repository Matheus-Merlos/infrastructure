
resource "aws_iam_user" "db_user" {
  name = "neon-bot-db-user"

  lifecycle {
    ignore_changes = [tags]
  }
}

data "aws_iam_policy_document" "db_user_policy" {
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:ListTables",
      "dynamodb:DescribeTable",
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:Query",
      "dynamodb:Scan"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "db_user_policy" {
  name   = "NeonBotDBUserPolicy"
  policy = data.aws_iam_policy_document.db_user_policy.json
}

resource "aws_iam_user_policy_attachment" "db_user_attachment" {
  user       = aws_iam_user.db_user.name
  policy_arn = aws_iam_policy.db_user_policy.arn
}

resource "aws_iam_access_key" "db_user_access_key" {
  user = aws_iam_user.db_user.id
}