locals {
  # common
  cluster_name = var.cluster_name != null ? var.cluster_name : "digitalcosmo"

  # networking
  subnet_ids = var.subnet_ids != null ? var.subnet_ids : concat(
    try(data.aws_subnets.private_subnets[0].ids, []),
    try(data.aws_subnets.public_subnets[0].ids, [])
  )

  # aws_eks_cluster
  security_group_ids = concat([aws_security_group.eks_cluster_default_sg.id], var.additional_security_group_ids)
  
  # aws_eks_identity_provider_config
  
  # aws_eks_access_policy_association
  
  # aws_eks_access_entry
  
  # aws_eks_node_group
  
  # aws_eks_fargate_profile
  fargate_profile_enabled = var.fargate_profile_enabled && var.selectors != null
  
  # aws_eks_addon
  addons = merge(
    local.core_addons,
    local.cloudwatch_observability,
    var.addons
  )

  core_addons = {
    # CoreDNS is a DNS add-on that handles service discovery within the Kubernetes cluster.
    # - Needs to run on worker nodes (Node Groups) to function as a cluster DNS provider.
    # - Required for other services, like ArgoCD, that rely on internal DNS to locate resources.
    "coredns" = {
      addon_version               = "v1.11.1-eksbuild.8"
      configuration_values        = null
      resolve_conflicts_on_create = "NONE"
      resolve_conflicts_on_update = "PRESERVE"
      preserve                    = false
      service_account_role_arn    = aws_iam_role.oidc_role.arn
      tags                        = { Name = "coredns" }
    },
    # VPC CNI (Container Network Interface) handles networking for Kubernetes pods within AWS VPC.
    # - Enables the cluster to assign VPC IP addresses to pods, allowing direct VPC connectivity.
    # - Essential for any cluster networking, including cross-node and external communications.
    "vpc-cni" = {
      addon_version               = "v1.18.1-eksbuild.3"
      configuration_values        = null
      resolve_conflicts_on_create = "NONE"
      resolve_conflicts_on_update = "OVERWRITE"
      preserve                    = false
      service_account_role_arn    = null
      tags                        = { Name = "vpc-cni" }
    },
    # Kube-Proxy manages networking rules on nodes to enable pod-to-pod and pod-to-service communications.
    # - Essential for managing internal networking within the Kubernetes cluster.
    # - Configures iptables and IPVS rules on nodes, enabling the Kubernetes service abstraction.
    "kube-proxy" = {
      addon_version               = "v1.30.0-eksbuild.3"
      configuration_values        = null
      resolve_conflicts_on_create = "NONE"
      resolve_conflicts_on_update = "PRESERVE"
      preserve                    = false
      service_account_role_arn    = aws_iam_role.oidc_role.arn
      tags                        = { Name = "kube-proxy" }
    }
    # EKS Pod Identity Agent enables IAM roles for service accounts (IRSA) within EKS.
    # - Needed for enabling pods to assume IAM roles, allowing secure access to AWS services.
    # - Provides the mechanism for service accounts to be associated with IAM roles using OIDC.
    "eks-pod-identity-agent" = {
      addon_version               = "v1.3.2-eksbuild.2"
      configuration_values        = null
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      preserve                    = false
      service_account_role_arn    = aws_iam_role.oidc_role.arn
      tags                        = { Name = "eks-pod-identity-agent" }
    }
  }

  cloudwatch_observability = var.cloudwatch_observability_enabled ? {
    # CloudWatch Observability integrates Amazon CloudWatch with EKS for monitoring and logging.
    # - Sends cluster and pod-level metrics to CloudWatch for observability and performance analysis.
    # - Allows for more advanced metrics and insights into EKS workloads.

    # Amazon CloudWatch Observability add-on comes with CloudWatch Application Signals enabled by default.
    # To get Application Signals on your services, make sure you have version v1.7.0-eksbuild.1 or above of
    # the add-on and complete additional steps in the Application Signals console.
    "amazon-cloudwatch-observability" = {
      addon_version               = "v2.2.1-eksbuild.1"
      configuration_values        = null
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      preserve                    = false
      service_account_role_arn    = aws_iam_role.oidc_role.arn
      tags                        = { Name = "amazon-cloudwatch-observability" }
    }
  } : {}

  datadog_operator = var.datadog_observability_enabled ? {
    # Datadog Operator deploys Datadog agents and manages their lifecycle on EKS.
    # - The Operator automates Datadog Agent deployment across the cluster for metrics, logs, and traces.
    # - Provides full observability for EKS workloads, integrating Datadog with Kubernetes.

    # The Datadog Operator can be customized with specific configurations for metrics, logging, and tracing.
    # Make sure the Datadog API and application keys are securely configured and available as Kubernetes secrets.
    "datadog_operator" = {
      addon_version               = "v0.6.0"
      configuration_values        = null
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      preserve                    = false
      service_account_role_arn    = aws_iam_role.oidc_role.arn
      tags                        = { Name = "datadog_operator" }
    }
  } : {}


  
  # aws_eks_pod_identity_association

  # AWS Load Balancer Controller

  # Standard Kubernetes Dashboard

  # keda

  # argocd

  # managed_prometheus_workspaces

}

