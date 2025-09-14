variable "vpc_id" {
  description = "ID da VPC onde o EKS será criado"
  type        = string
}

variable "iam_role_arn" {
  description = "ARN da IAM Role para ser usada pelo EKS"
  type        = string
  default     = "arn:aws:iam::933883094183:role/LabRole"
} 