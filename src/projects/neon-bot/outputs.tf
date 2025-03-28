output "db_password" {
  value     = random_string.postgresql_password.result
  sensitive = true
}