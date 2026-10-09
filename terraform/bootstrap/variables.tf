variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "taskflow"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
