module "neon-bot" {
  source = "./projects/neon-bot"

  vpc_id             = aws_vpc.main_vpc.id
  private_subnet_ids = local.public_subnets
}

output "neon_bot_db_password" {
  value     = module.neon-bot.db_password
  sensitive = true
}