variable "aws_region" {
  description = "Região da AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Ambiente do deployment (Ex: dev, staging, prod)"
  type        = string
  default     = "dev"
}
