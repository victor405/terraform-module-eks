################################################################################
#####   common
################################################################################

variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = null
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

################################################################################
#####   networking
################################################################################

variable "vpc_id" {
  description = "VPC ID for the EKS cluster"
  default     = null
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  default     = null
}

################################################################################
#####   aws_eks_cluster
################################################################################

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
}

variable "additional_security_group_ids" {
  description = "List of additional security group IDs for the EKS cluster"
  default = []
}

variable "endpoint_public_access" {
  description = "Enable public access to the EKS cluster endpoint"
  default     = false
}

variable "endpoint_private_access" {
  description = "Enable private access to the EKS cluster endpoint"
  default     = true
}

variable "public_access_cidrs" {
  description = "List of CIDR blocks for public access"
  default     = ["0.0.0.0/0"]
}

variable "network_config" {
  description = "List of network configuration settings for Kubernetes network config, including IP family and service IPv4 CIDR."
  type = list(object({
    ip_family         = string
    service_ipv4_cidr = optional(string)
  }))
  default = []
}

variable "authentication_mode" {
  description = "Authentication mode for the cluster"
  default     = "API_AND_CONFIG_MAP"
}

variable "bootstrap_cluster_creator_admin_permissions" {
  description = "Bootstrap admin permissions for cluster creator"
  default     = true
}

variable "enabled_cluster_log_types" {
  description = "List of control plane log types to enable"
  default     = ["api","audit","authenticator","controllerManager","scheduler"]
}

variable "bootstrap_self_managed_addons" {
  description = "Install default unmanaged add-ons during cluster creation"
  default     = true
}

variable "update_policy" {
  description = "List of update policies for EKS cluster, including support type for upgrade policy."
  type = list(object({
    support_type = string
  }))
  default = [
    {
      support_type = "STANDARD"
    }
  ]
}

variable "outpost_config" {
  description = "List of Outpost configuration settings, including control plane instance type, Outpost ARNs, and control plane placement group name."
  type = list(object({
    control_plane_instance_type      = string
    outpost_arns                     = list(string)
    control_plane_placement_group_name = optional(string)
  }))
  default = []
}

variable "encryption_config_enabled" {
  description = "Enable encryption configuration for the cluster"
  default     = true
}

variable "encryption_config_kms_key_arn" {
  description = "KMS key ARN to use for encryption. If null and encryption is enabled, a new KMS key will be created."
  default     = null
}

variable "encryption_config_resources" {
  description = "List of resources to encrypt. Default is ['secrets']."
  default     = ["secrets"]
}

variable "zonal_shift_config" {
  description = "Configuration for enabling zonal shift, with an enabled flag."
  type = list(object({
    enabled = bool
  }))
  default = []
}

variable "eks_cluster_tags" {
  description = "Tags for the EKS cluster"
  default     = null
}

################################################################################
#####   aws_eks_identity_provider_config
################################################################################

variable "identity_providers" {
  description = "Map of OIDC identity provider configurations"
  type = map(object({
    client_id                     = string
    identity_provider_config_name = string
    issuer_url                    = string
    groups_claim                  = string
    groups_prefix                 = string
    required_claims               = map(string)
    username_claim                = string
    username_prefix               = string
    tags                          = map(string)
  }))
  default = {}
}

################################################################################
#####   aws_eks_access_policy_association
################################################################################

variable "access_policy_associations" {
  description = "Map of EKS access policy associations"
  type = map(object({
    policy_arn     = string
    principal_arn  = string
    access_scope = object({
      type       = string
      namespaces = list(string)
    })
  }))
  default = {}
}


################################################################################
#####   aws_eks_access_entry
################################################################################

variable "eks_access_entries" {
  description = "Map of EKS access entries with specific configurations"
  type = map(object({
    principal_arn     = string
    kubernetes_groups = list(string)
    type              = string
    user_name         = string
    tags              = map(string)
  }))
  default = {}
}

################################################################################
#####   aws_eks_node_group
################################################################################

variable "node_groups" {
  type = map(object({
    ami_type               = optional(string, null)
    release_version        = optional(string, null)
    capacity_type          = optional(string, "ON_DEMAND")
    disk_size              = optional(number, null)
    force_update_version   = optional(bool, null)
    instance_types         = optional(list(string), ["t3.medium"])
    labels                 = optional(map(string), {})
    desired_size           = optional(number, 2)
    max_size               = optional(number, 1)
    min_size               = optional(number, 1)
    update_config          = optional(list(object({
      max_unavailable            = optional(number)
      max_unavailable_percentage = optional(number)
    })), [])
    remote_access = optional(list(object({
      ec2_ssh_key               = optional(string)
      source_security_group_ids = optional(list(string))
    })), [])
    launch_template = optional(list(object({
      id      = optional(string)
      name    = optional(string)
      version = optional(string)
    })), [])
    taints = optional(list(object({
      key    = string
      value  = optional(string)
      effect = string
    })), [])
    tags = optional(map(string), {})
  }))
}


################################################################################
#####   aws_eks_fargate_profile
################################################################################

variable "fargate_profiles" {
  type = map(object({
    selectors = optional(list(object({
      namespace = string
      labels    = optional(map(string), {})
    })), [])
    tags       = optional(map(string), {})
  }))
  default = {}
}


################################################################################
#####   aws_eks_addon
################################################################################

variable "cloudwatch_observability_enabled" {
  description = "Enable CloudWatch observability for the EKS cluster"
  default     = false
}

variable "datadog_observability_enabled" {
  description = "Enable Datadog observability for the EKS cluster"
  default     = false
}

variable "addons" {
  description = "Map of EKS addons with their configurations"
  type = map(object({
    addon_version               = string
    configuration_values        = string
    resolve_conflicts_on_create = string
    resolve_conflicts_on_update = string
    preserve                    = bool
    service_account_role_arn    = string
    tags                        = map(string)
  }))
  default = {}
}


################################################################################
#####   aws_eks_pod_identity_association
################################################################################

variable "pod_identity_associations" {
  description = "Map of EKS pod identity associations"
  type = map(object({
    namespace       = string
    service_account = string
    role_arn        = string
    tags            = map(string)
  }))
  default = {}
}

################################################################################
#####   AWS Load Balancer Controller
################################################################################

variable "aws_load_balancer_controller_enabled" {
  description = "Enable AWS Load Balancer Controller for the EKS cluster"
  default     = true
}

################################################################################
#####   keda
################################################################################

variable "keda_enabled" {
  description = "Enable KEDA for the EKS cluster"
  default     = true
}

################################################################################
#####   Standard Kubernetes Dashboard
################################################################################

variable "kubernetes_dashboard_enabled" {
  description = "Enable Kubernetes Dashboard for the EKS cluster"
  default     = true
}

################################################################################
#####   argocd
################################################################################

variable "argocd_enabled" {
  description = "Enable Argo CD for the EKS cluster"
  default     = false
}

################################################################################
#####   managed_prometheus_workspaces
################################################################################

variable "prometheus_workspaces" {
  description = "Map of Prometheus workspaces with their configurations"
  type = map(object({
    # aws_prometheus_workspace
    kms_key_arn           = optional(string)
    logging_configuration = list(object({
      log_group_arn = string
    }))

    # aws_prometheus_rule_group_namespace
    prometheus_rule_groups = map(object({
      data = string
    }))

    # aws_prometheus_scraper
    scrape_configuration = string

    # aws_prometheus_alert_manager_definition
    alert_manager_definition = string
  }))

  default = {}
}
