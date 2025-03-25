resource "aws_dynamodb_table" "neon_bot_table_players" {
  name         = "neon-bot-players"
  billing_mode = "PAY_PER_REQUEST"

  hash_key  = "playerId"
  range_key = "guildId"

  attribute {
    name = "playerId"
    type = "S"
  }

  attribute {
    name = "guildId"
    type = "N"
  }
}