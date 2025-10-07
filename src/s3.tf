resource "aws_s3_bucket" "neon_database_dumps" {
  bucket = "neon-bot-database-dumps"
}

resource "aws_s3_bucket_lifecycle_configuration" "neon_database_dumps_lifecycle" {
  bucket = aws_s3_bucket.neon_database_dumps.id

  rule {
    id     = "delete-old-files"
    status = "Enabled"

    filter {
      prefix = ""
    }

    expiration {
      days = 60
    }
  }
}
