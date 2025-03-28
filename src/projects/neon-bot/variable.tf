variable "vpc_id" {
  type        = string
  description = "The id of the main VPC"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "A list containing at least 2 IDs of 2 private subnets"
}