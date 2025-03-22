resource "aws_ecs_cluster" "tf_services" {
  name = "tf-services"
}

data "aws_iam_policy_document" "ecs_task_execution_policy_document" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"

  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_policy_document.json
}
resource "aws_iam_role" "ecs_task_role" {
  name = "ecs-task-role"

  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_policy_document.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
