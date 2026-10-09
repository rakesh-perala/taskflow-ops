variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  type    = string
  default = "taskflow"
}

variable "environment" {
  type    = string
  default = "dev"
}
