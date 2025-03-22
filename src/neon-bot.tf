resource "aws_security_group" "ec2_security_group" {
  name   = "ec2-ssh-security-group"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "neon_bot_main_server" {
  ami           = "ami-0789039e34e739d67"
  instance_type = "t4g.nano"
  key_name      = "neon-bot-key-pair"

  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  subnet_id              = aws_subnet.us_east_1a_public_subnet.id

  tags = {
    Name       = "tf-neon-bot"
    Auto-Start = true
  }
}

module "neon_bot_images_bucket" {
  source = "../modules/s3-bucket"

  bucket_name = "neon-bot-images"
  acl         = "public-read"
}

output "server_dns" {
  value = aws_instance.neon_bot_main_server.public_dns
}
