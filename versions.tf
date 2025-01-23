terraform {
  # Allows to use the optional function in variable type definitions
  experiments = [module_variable_optional_attrs]

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.5"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.13"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Specify the required Terraform version if applicable
  required_version = ">= 1.0.0"
}