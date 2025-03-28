
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
      "rds-db:connect"
    ]
    resources = [
      "arn:aws:rds-db:us-east-1:${data.aws_caller_identity.this.account_id}:dbuser:${aws_db_instance.neon_bot_postgresql.id}/iam_user"
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