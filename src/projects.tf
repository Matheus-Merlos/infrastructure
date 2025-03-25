module "neon-bot" {
  source = "./projects/neon-bot"
}

output "db_user_access_key_id" {
  value     = module.neon-bot.db_user_access_key_id
  sensitive = true
}

output "db_user_secret_access_key" {
  value     = module.neon-bot.db_user_secret_access_key
  sensitive = true
}