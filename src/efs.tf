resource "aws_efs_file_system" "container_efs" {
  creation_token   = "neon-bot-efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"

  tags = {
    Name = "neon-bot-efs"
  }
}

resource "aws_security_group" "container_efs_sg" {
  name = "neon-bot-efs-sg"

  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [var.us_east_1a_subnet_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_efs_mount_target" "container_efs_mounts" {
  file_system_id  = aws_efs_file_system.container_efs.id
  subnet_id       = aws_subnet.us_east_1a_public_subnet.id
  security_groups = [aws_security_group.container_efs_sg.id]
}

output "efs_id" {
  value     = aws_efs_file_system.container_efs.id
  sensitive = true
}