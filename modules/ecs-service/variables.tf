variable "service_name" {
  type        = string
  description = "Name of the Service"
}

variable "cluster_id" {
  type        = string
  description = "The cluster that the service will be created in"
}

variable "task_name" {
  type        = string
  description = "The name of the task definition"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}

variable "public_subnets" {
  type        = list(string)
  description = "The subnets of the service"
}

variable "subnets_cidr_blocks" {
  type = list(string)
}