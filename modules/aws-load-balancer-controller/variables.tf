variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = null
}

variable "vpc_id" {
  description = "VPC ID for the EKS cluster"
  default     = null
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "oidc_role_arn" {
  description = "OIDC role ARN for the EKS cluster"
  default     = null
}

variable "oidc_role_url" {
  description = "OIDC role URL for the EKS cluster"
  default     = null
}