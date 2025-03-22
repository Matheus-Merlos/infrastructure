data "aws_ecs_task_definition" "latest_task_definition" {
  task_definition = var.task_name
}

resource "aws_security_group" "service_security_group" {
  name   = "${var.service_name}-sg"
  vpc_id = var.vpc_id

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

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = var.subnets_cidr_blocks[0]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_service" "this" {
  name    = var.service_name
  cluster = var.cluster_id

  task_definition = "${var.task_name}:${data.aws_ecs_task_definition.latest_task_definition.revision}"
  desired_count   = 1

  launch_type = "FARGATE"

  network_configuration {
    subnets         = var.public_subnets
    security_groups = [aws_security_group.service_security_group.id]
    assign_public_ip = false
  }
}