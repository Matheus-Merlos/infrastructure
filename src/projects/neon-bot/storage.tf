resource "aws_dynamodb_table" "neon_bot_table_players" {
  name         = "neon-bot-players"
  billing_mode = "PAY_PER_REQUEST"

  hash_key  = "id"
  range_key = "guildId"

  attribute {
    name = "id"
    type = "N"
  }

  attribute {
    name = "guildId"
    type = "N"
  }
}