################################################################################
#####   aws_eks_cluster
################################################################################

output "cluster_id" {
  description = "The name of the EKS cluster."
  value       = aws_eks_cluster.eks.id
}

output "cluster_arn" {
  description = "The ARN of the EKS cluster."
  value       = aws_eks_cluster.eks.arn
}

output "cluster_endpoint" {
  description = "The endpoint for your Kubernetes API server."
  value       = aws_eks_cluster.eks.endpoint
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with your cluster."
  value       = aws_eks_cluster.eks.certificate_authority[0].data
}

output "cluster_identity_oidc_issuer" {
  description = "Issuer URL for the OpenID Connect identity provider."
  value       = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

output "cluster_status" {
  description = "The status of the EKS cluster."
  value       = aws_eks_cluster.eks.status
}

output "cluster_created_at" {
  description = "Unix epoch timestamp in seconds for when the cluster was created."
  value       = aws_eks_cluster.eks.created_at
}

output "cluster_platform_version" {
  description = "Platform version for the cluster."
  value       = aws_eks_cluster.eks.platform_version
}

output "cluster_version" {
  description = "The Kubernetes server version for the EKS cluster."
  value       = aws_eks_cluster.eks.version
}

output "cluster_vpc_id" {
  description = "ID of the VPC associated with your cluster."
  value       = aws_eks_cluster.eks.vpc_config[0].vpc_id
}

output "cluster_security_group_id" {
  description = "Cluster security group created by Amazon EKS for the cluster."
  value       = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
}

output "cluster_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = aws_eks_cluster.eks.tags_all
}

# If you have IPv6 enabled
output "cluster_service_ipv6_cidr" {
  description = "The CIDR block that Kubernetes pod and service IP addresses are assigned from if IPv6 is used."
  value       = aws_eks_cluster.eks.kubernetes_network_config[0].service_ipv6_cidr
}


################################################################################
#####   aws_eks_identity_provider_config
################################################################################

output "eks_identity_provider_arns" {
  description = "ARN of the EKS Identity Provider Configuration."
  value       = { for k, v in aws_eks_identity_provider_config.eks : k => v.arn }
}

output "eks_identity_provider_ids" {
  description = "EKS Cluster name and EKS Identity Provider Configuration name separated by a colon (:)."
  value       = { for k, v in aws_eks_identity_provider_config.eks : k => v.id }
}

output "eks_identity_provider_statuses" {
  description = "Status of the EKS Identity Provider Configuration."
  value       = { for k, v in aws_eks_identity_provider_config.eks : k => v.status }
}

output "eks_identity_provider_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = { for k, v in aws_eks_identity_provider_config.eks : k => v.tags_all }
}


################################################################################
#####   aws_eks_access_policy_association
################################################################################

output "eks_associated_access_policies" {
  description = "Contains information about the access policy association."
  value       = { for k, v in aws_eks_access_policy_association.eks : k => v.associated_access_policy }
}

output "eks_associated_access_policy_associated_at" {
  description = "Date and time in RFC3339 format that the policy was associated."
  value       = { for k, v in aws_eks_access_policy_association.eks : k => v.associated_access_policy[0].associated_at }
}

output "eks_associated_access_policy_modified_at" {
  description = "Date and time in RFC3339 format that the policy was updated."
  value       = { for k, v in aws_eks_access_policy_association.eks : k => v.associated_access_policy[0].modified_at }
}


################################################################################
#####   aws_eks_access_entry
################################################################################

output "eks_access_entry_arns" {
  description = "Amazon Resource Name (ARN) of the Access Entry."
  value       = { for k, v in aws_eks_access_entry.eks : k => v.access_entry_arn }
}

output "eks_access_entry_created_at" {
  description = "Date and time in RFC3339 format that the EKS add-on was created."
  value       = { for k, v in aws_eks_access_entry.eks : k => v.created_at }
}

output "eks_access_entry_modified_at" {
  description = "Date and time in RFC3339 format that the EKS add-on was updated."
  value       = { for k, v in aws_eks_access_entry.eks : k => v.modified_at }
}

output "eks_access_entry_tags_all" {
  description = "Key-value map of resource tags, including those inherited from the provider default_tags configuration block."
  value       = { for k, v in aws_eks_access_entry.eks : k => v.tags_all }
}


################################################################################
#####   aws_eks_node_group
################################################################################

output "eks_node_group_arn" {
  description = "Amazon Resource Name (ARN) of the EKS Node Group."
  value       = aws_eks_node_group.eks[0].arn
}

output "eks_node_group_id" {
  description = "EKS Cluster name and EKS Node Group name separated by a colon (:)."
  value       = aws_eks_node_group.eks[0].id
}

output "eks_node_group_resources" {
  description = "List of objects containing information about underlying resources."
  value       = aws_eks_node_group.eks[0].resources
}

output "eks_node_group_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = aws_eks_node_group.eks[0].tags_all
}

output "eks_node_group_status" {
  description = "Status of the EKS Node Group."
  value       = aws_eks_node_group.eks[0].status
}


################################################################################
#####   aws_eks_fargate_profile
################################################################################

output "eks_fargate_profile_arn" {
  description = "Amazon Resource Name (ARN) of the EKS Fargate Profile."
  value       = aws_eks_fargate_profile.eks[0].arn
}

output "eks_fargate_profile_id" {
  description = "EKS Cluster name and EKS Fargate Profile name separated by a colon (:)."
  value       = aws_eks_fargate_profile.eks[0].id
}

output "eks_fargate_profile_status" {
  description = "Status of the EKS Fargate Profile."
  value       = aws_eks_fargate_profile.eks[0].status
}

output "eks_fargate_profile_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = aws_eks_fargate_profile.eks[0].tags_all
}


################################################################################
#####   aws_eks_addon
################################################################################

output "eks_addon_arns" {
  description = "Amazon Resource Name (ARN) of the EKS add-on."
  value       = { for k, v in aws_eks_addon.eks : k => v.arn }
}

output "eks_addon_ids" {
  description = "EKS Cluster name and EKS Addon name separated by a colon (:)."
  value       = { for k, v in aws_eks_addon.eks : k => v.id }
}

output "eks_addon_statuses" {
  description = "Status of the EKS add-on."
  value       = try({ for k, v in aws_eks_addon.eks : k => v.status }, {})
}

output "eks_addon_created_at" {
  description = "Date and time in RFC3339 format that the EKS add-on was created."
  value       = { for k, v in aws_eks_addon.eks : k => v.created_at }
}

output "eks_addon_modified_at" {
  description = "Date and time in RFC3339 format that the EKS add-on was updated."
  value       = { for k, v in aws_eks_addon.eks : k => v.modified_at }
}

output "eks_addon_tags_all" {
  description = "Key-value map of resource tags, including those inherited from the provider default_tags configuration block."
  value       = { for k, v in aws_eks_addon.eks : k => v.tags_all }
}



################################################################################
#####   aws_eks_pod_identity_association
################################################################################

output "eks_pod_identity_association_arns" {
  description = "The Amazon Resource Name (ARN) of the association."
  value       = { for k, v in aws_eks_pod_identity_association.eks : k => v.association_arn }
}

output "eks_pod_identity_association_ids" {
  description = "The ID of the association."
  value       = { for k, v in aws_eks_pod_identity_association.eks : k => v.association_id }
}

output "eks_pod_identity_association_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = { for k, v in aws_eks_pod_identity_association.eks : k => v.tags_all }
}

################################################################################
#####   AWS Load Balancer Controller
################################################################################

################################################################################
#####   Standard Kubernetes Dashboard
################################################################################

################################################################################
#####   keda
################################################################################

################################################################################
#####   argocd
################################################################################

################################################################################
#####   managed_prometheus_workspaces
################################################################################

output "prometheus_workspace_arns" {
  description = "Amazon Resource Names (ARNs) of each Prometheus workspace"
  value       = { for key, workspace in module.managed_prometheus_workspaces : key => workspace.prometheus_workspace_arn }
}

output "prometheus_workspace_ids" {
  description = "Identifiers of each Prometheus workspace"
  value       = { for key, workspace in module.managed_prometheus_workspaces : key => workspace.prometheus_workspace_id }
}

output "prometheus_workspace_endpoints" {
  description = "Prometheus endpoints available for each workspace"
  value       = { for key, workspace in module.managed_prometheus_workspaces : key => workspace.prometheus_workspace_endpoint }
}

output "prometheus_workspace_tags_all" {
  description = "Maps of tags assigned to each Prometheus workspace, including inherited tags"
  value       = { for key, workspace in module.managed_prometheus_workspaces : key => workspace.prometheus_workspace_tags_all }
}

output "prometheus_scraper_arns" {
  description = "Amazon Resource Names (ARNs) of each Prometheus scraper"
  value       = { for key, workspace in module.managed_prometheus_workspaces : key => workspace.prometheus_scraper_arn }
}

output "prometheus_scraper_role_arns" {
  description = "Amazon Resource Names (ARNs) of IAM roles used by each Prometheus scraper"
  value       = { for key, workspace in module.managed_prometheus_workspaces : key => workspace.prometheus_scraper_role_arn }
}
