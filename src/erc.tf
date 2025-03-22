resource "aws_ecr_repository" "projects_repository" {
  name                 = "projects"
  image_tag_mutability = "MUTABLE"
}