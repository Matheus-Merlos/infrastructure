module "neon_bot_images_bucket" {
  source = "../modules/s3-bucket"

  bucket_name = "neon-bot-images"
  acl         = "public-read"
}
