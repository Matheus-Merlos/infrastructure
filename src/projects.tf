module "neon-bot" {
  source = "./projects/neon-bot"

  vpc_id             = aws_vpc.main_vpc.id
  private_subnet_ids = local.public_subnets
}

output "db_user_access_key_id" {
  value     = module.neon-bot.db_user_access_key_id
  sensitive = true
}

output "db_user_secret_access_key" {
  value     = module.neon-bot.db_user_secret_access_key
  sensitive = true
}

output "neon_bot_db_password" {
  value     = module.neon-bot.db_password
  sensitive = true
}