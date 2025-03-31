resource "random_string" "postgresql_password" {
  length  = 32
  special = false
}

resource "aws_db_subnet_group" "neon_bot_subnet_group" {
  name = "neon-bot-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "neon-bot-subnet-group"
  }
}

resource "aws_db_parameter_group" "neon_bot_postgresql_parameter_group" {
  name   = "neon-bot-postgresql-parameter-group"
  family = "postgres15"

  parameter {
    name  = "rds.force_ssl"
    value = "0"
  }

  parameter {
    name         = "max_connections"
    value        = "6"
    apply_method = "pending-reboot"
  }
}

resource "aws_db_instance" "neon_bot_postgresql" {
  identifier = "postgres-neon-bot"

  vpc_security_group_ids = [ aws_security_group.postgresql_sg.id ]
  db_subnet_group_name   = aws_db_subnet_group.neon_bot_subnet_group.name

  engine               = "postgres"
  engine_version       = "15.12"
  instance_class       = "db.t4g.micro"
  parameter_group_name = aws_db_parameter_group.neon_bot_postgresql_parameter_group.name

  allocated_storage = 20
  storage_type      = "gp2"

  username = "postgres"
  password = random_string.postgresql_password.result

  storage_encrypted   = false
  publicly_accessible = true
  skip_final_snapshot = true
  multi_az            = false

  backup_retention_period  = 0
  delete_automated_backups = true

  performance_insights_enabled = false
  monitoring_interval          = 0
  apply_immediately            = true

  tags = {
    Auto-Start = true
  }
}