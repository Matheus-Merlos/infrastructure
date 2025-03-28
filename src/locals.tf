locals {
  public_subnets = [aws_subnet.us_east_1a_public_subnet.id, aws_subnet.us_east_1b_public_subnet.id]
}