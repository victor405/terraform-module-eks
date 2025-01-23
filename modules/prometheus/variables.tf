################################################################################
#####   aws_prometheus_workspace
################################################################################

variable "alias" {
  description = "Alias name for the Prometheus workspace."
}

variable "kms_key_arn" {
  description = "KMS Key ARN for encrypting Prometheus workspace data."
  default     = "USE AWS Managed Key"
}

variable "logging_configuration" {
  description = "List of logging configurations with log group ARNs for the Prometheus workspace."
  type = list(object({
    log_group_arn = string
  }))
  default = []
}


################################################################################
#####   aws_prometheus_rule_group_namespace
################################################################################

variable "prometheus_rule_groups" {
  description = "Map of rule group namespaces with workspace IDs and rule data"
  type = map(object({
    data = string
  }))
  default = {}
}

################################################################################
#####   aws_prometheus_scraper
################################################################################

variable "scrape_configuration" {
  description = "List of Prometheus scrape configurations."
  default     = null
}

variable "cluster_arn" {
  description = "The ARN of the EKS cluster."
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster."
}

variable "security_group_ids" {
  description = "List of security group IDs for the EKS cluster."
}

################################################################################
#####   aws_prometheus_alert_manager_definition
################################################################################

variable "alert_manager_definition" {
  description = "List of alert manager definitions."
  default     = null
}