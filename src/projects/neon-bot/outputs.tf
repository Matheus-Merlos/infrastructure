output "db_user_access_key_id" {
  value     = aws_iam_access_key.db_user_access_key.id
  sensitive = true
}

output "db_user_secret_access_key" {
  value     = aws_iam_access_key.db_user_access_key.secret
  sensitive = true
}