################################################################################
#####   aws_eks_cluster
################################################################################

resource "aws_eks_cluster" "eks" {
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_vpc_resource_controller,
  ]

  name                          = local.cluster_name
  role_arn                      = aws_iam_role.eks_cluster_role.arn
  version                       = var.kubernetes_version
  enabled_cluster_log_types     = var.enabled_cluster_log_types
  bootstrap_self_managed_addons = var.bootstrap_self_managed_addons

  access_config {
    authentication_mode                         = var.authentication_mode
    bootstrap_cluster_creator_admin_permissions = var.bootstrap_cluster_creator_admin_permissions
  }

  vpc_config {
    subnet_ids              = local.subnet_ids
    security_group_ids      = local.security_group_ids
    endpoint_public_access  = var.endpoint_public_access
    endpoint_private_access = var.endpoint_private_access
    public_access_cidrs     = var.public_access_cidrs
  }

  dynamic "kubernetes_network_config" {
    for_each = var.network_config

    content {
      ip_family         = kubernetes_network_config.value.ip_family
      service_ipv4_cidr = kubernetes_network_config.value.service_ipv4_cidr
    }
  }

  dynamic "outpost_config" {
    for_each = var.outpost_config

    content {
      control_plane_instance_type = outpost_config.value.control_plane_instance_type
      outpost_arns                = outpost_config.value.outpost_arns

      control_plane_placement {
        group_name = outpost_config.value.control_plane_placement_group_name
      }
    }
  }

  dynamic "encryption_config" {
    for_each = var.encryption_config_enabled ? [1] : []

    content {
      provider {
        key_arn = var.encryption_config_kms_key_arn != null ? var.encryption_config_kms_key_arn : aws_kms_key.eks_cluster_encryption_key[0].arn
      }
      resources = var.encryption_config_resources
    }
  }

  dynamic "upgrade_policy" {
    for_each = var.update_policy

    content {
      support_type = upgrade_policy.value.support_type
    }
  }

  dynamic "zonal_shift_config" {
    for_each = var.zonal_shift_config

    content {
      enabled = zonal_shift_config.value.enabled
    }
  }

  tags = merge(
    { Name = local.cluster_name },
    var.eks_cluster_tags
  )
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "${local.cluster_name}-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_security_group" "eks_cluster_default_sg" {
  name        = "${local.cluster_name}-default-sg"
  description = "Default security group for EKS cluster communication"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.cluster_name}-default-sg"
  }
}

resource "aws_kms_key" "eks_cluster_encryption_key" {
  count       = var.encryption_config_enabled && var.encryption_config_kms_key_arn == null ? 1 : 0
  description = "AWS KMS Key to encrypt EKS Cluster Secrets"
}

resource "aws_kms_alias" "eks_cluster_encryption_key_alias" {
  count         = var.encryption_config_enabled && var.encryption_config_kms_key_arn == null ? 1 : 0
  name          = "alias/${local.cluster_name}-encryption-key"
  target_key_id = aws_kms_key.eks_cluster_encryption_key[0].key_id
}

resource "aws_iam_openid_connect_provider" "provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.oidc_tls.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

resource "aws_iam_role" "oidc_role" {
  assume_role_policy = data.aws_iam_policy_document.oidc_iam_policy_document.json
  name               = "${local.cluster_name}-oidc-role"
}


################################################################################
#####   aws_eks_identity_provider_config
################################################################################

resource "aws_eks_identity_provider_config" "eks" {
  depends_on   = [aws_eks_cluster.eks]
  for_each     = var.identity_providers
  cluster_name = local.cluster_name

  oidc {
    client_id                     = each.value.client_id
    identity_provider_config_name = each.value.identity_provider_config_name
    issuer_url                    = each.value.issuer_url
    groups_claim                  = each.value.groups_claim
    groups_prefix                 = each.value.groups_prefix
    required_claims               = each.value.required_claims
    username_claim                = each.value.username_claim
    username_prefix               = each.value.username_prefix
  }

  tags = each.value.tags
}


################################################################################
#####   aws_eks_access_policy_association
################################################################################

resource "aws_eks_access_policy_association" "eks" {
  depends_on   = [aws_eks_cluster.eks]
  for_each     = var.access_policy_associations
  cluster_name = local.cluster_name
  policy_arn   = each.value.policy_arn
  principal_arn = each.value.principal_arn

  access_scope {
    type       = each.value.access_scope.type
    namespaces = each.value.access_scope.namespaces
  }
}


################################################################################
#####   aws_eks_access_entry
################################################################################

resource "aws_eks_access_entry" "eks" {
  depends_on        = [aws_eks_cluster.eks]
  for_each          = var.eks_access_entries
  cluster_name      = local.cluster_name
  principal_arn     = each.value.principal_arn
  kubernetes_groups = each.value.kubernetes_groups
  type              = each.value.type
  user_name         = each.value.user_name
  tags              = each.value.tags
}


################################################################################
#####   aws_eks_node_group
################################################################################

resource "aws_eks_node_group" "eks" {
  depends_on = [aws_eks_cluster.eks]

  for_each = var.node_groups

  cluster_name           = local.cluster_name
  node_group_name        = "${local.cluster_name}-${each.key}"
  node_group_name_prefix = null
  node_role_arn          = aws_iam_role.eks_node_group_role[0].arn
  subnet_ids             = var.subnet_ids
  ami_type               = each.value.ami_type
  release_version        = each.value.release_version
  capacity_type          = each.value.capacity_type
  disk_size              = each.value.disk_size
  force_update_version   = each.value.force_update_version
  instance_types         = each.value.instance_types
  labels                 = each.value.labels
  version                = var.kubernetes_version

  scaling_config {
    desired_size = each.value.desired_size
    max_size     = each.value.max_size
    min_size     = each.value.min_size
  }

  dynamic "update_config" {
    for_each = each.value.update_config

    content {
      max_unavailable            = update_config.value.max_unavailable
      max_unavailable_percentage = update_config.value.max_unavailable_percentage
    }
  }

  dynamic "remote_access" {
    for_each = each.value.remote_access

    content {
      ec2_ssh_key               = remote_access.value.ec2_ssh_key
      source_security_group_ids = remote_access.value.source_security_group_ids
    }
  }

  dynamic "launch_template" {
    for_each = each.value.launch_template

    content {
      id      = launch_template.value.id
      name    = launch_template.value.name
      version = launch_template.value.version
    }
  }

  dynamic "taint" {
    for_each = each.value.taints

    content {
      key    = taint.value.key
      value  = taint.value.value
      effect = taint.value.effect
    }
  }

  tags = merge(
    { Name = "${local.cluster_name}-${each.key}" },
    each.value.tags
  )
}


resource "aws_iam_role" "eks_node_group_role" {
  count = length(var.node_groups) > 0 ? 1 : 0
  name  = "${local.cluster_name}-node-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_group_policies" {
  count = length(var.node_groups) > 0 ? 3 : 0
  role       = aws_iam_role.eks_node_group_role[0].name
  policy_arn = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  ][count.index]
}

################################################################################
#####   aws_eks_fargate_profile
################################################################################

# May need to also live in the microservice module
# 100 profile limit and each can only have 5 selectors
resource "aws_eks_fargate_profile" "eks" {
  depends_on = [aws_eks_cluster.eks]

  for_each = var.fargate_profiles

  cluster_name           = local.cluster_name
  fargate_profile_name   = "${local.cluster_name}-${each.key}"
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution_role[0].arn
  subnet_ids             = var.subnet_ids

  dynamic "selector" {
    for_each = each.value.selectors

    content {
      namespace = selector.value.namespace
      labels    = selector.value.labels
    }
  }

  tags = merge(
    { Name = "${local.cluster_name}-${each.key}" },
    lookup(each.value, "tags", {})
  )
}

resource "aws_iam_role" "fargate_pod_execution_role" {
  count = length(var.fargate_profiles) > 0 ? 1 : 0
  name  = "eks_fargate_pod_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "fargate_pod_execution_role_policy" {
  count      = length(var.fargate_profiles) > 0
  role       = aws_iam_role.fargate_pod_execution_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}


################################################################################
#####   aws_eks_addon
################################################################################

resource "aws_eks_addon" "eks" {
  depends_on                  = [aws_eks_cluster.eks]
  for_each                    = local.addons
  cluster_name                = local.cluster_name
  addon_name                  = each.key
  addon_version               = each.value.addon_version
  configuration_values        = each.value.configuration_values
  resolve_conflicts_on_create = each.value.resolve_conflicts_on_create
  resolve_conflicts_on_update = each.value.resolve_conflicts_on_update
  preserve                    = each.value.preserve
  service_account_role_arn    = each.value.service_account_role_arn
  tags                        = each.value.tags
}


################################################################################
#####   aws_eks_pod_identity_association
################################################################################

# Be sure to install the Amazon EKS Pod Identity Agent add-on prior to creating, editing or deleting Pod Identity associations.
# This add-on is required for the EKS Pod Identity feature to function properly.

resource "aws_eks_pod_identity_association" "eks" {
  depends_on       = [aws_eks_cluster.eks]
  for_each         = var.pod_identity_associations
  cluster_name     = local.cluster_name
  namespace        = each.value.namespace
  service_account  = each.value.service_account
  role_arn         = each.value.role_arn
  tags             = each.value.tags
}

################################################################################
#####   AWS Load Balancer Controller
################################################################################

# Allows EKS to Manage AWS Load Balancers

module "aws_load_balancer_controller" {
  depends_on = [
    aws_eks_cluster.eks,
    aws_eks_identity_provider_config.eks,
    aws_eks_access_policy_association.eks,
    aws_eks_access_entry.eks,
    aws_eks_node_group.eks,
    aws_eks_fargate_profile.eks,
    aws_eks_addon.eks,
    aws_eks_pod_identity_association.eks
  ]

  source = "./modules/aws-load-balancer-controller"
  count  = var.aws_load_balancer_controller_enabled ? 1 : 0

  cluster_name  = local.cluster_name
  vpc_id        = var.vpc_id
  aws_region    = var.aws_region
  oidc_role_arn = aws_iam_openid_connect_provider.provider.arn
  oidc_role_url = aws_iam_openid_connect_provider.provider.url
}

################################################################################
#####   keda
################################################################################

resource "helm_release" "keda" {
  depends_on = [
    module.aws_load_balancer_controller
  ]

  count = var.keda_enabled ? 1 : 0

  name             = "keda"
  repository       = "https://kedacore.github.io/charts"
  chart            = "keda"
  namespace        = "keda"
  create_namespace = true

  values = [
    yamlencode({
      replicaCount = 1
    })
  ]
}

################################################################################
#####   Standard Kubernetes Dashboard
################################################################################

# Path
# > Route53 (DNS record pointing to ALB)
# > ALB (Application Load Balancer for external traffic)
# > Ingress (routing rules for traffic within the cluster)
# > Ingress Controller (implements Ingress rules, configures ALB)
# > ClusterIP Service (internal-only service for dashboard)
# > Kubernetes Dashboard (web UI for managing the cluster)

module "kubernetes_dashboard" {
  depends_on = [
    module.aws_load_balancer_controller
  ]

  source = "./modules/kubernetes-dashboard"
  count  = var.kubernetes_dashboard_enabled ? 1 : 0

  domain_name = "dashboard.example.com"
  zone_id     = ""
}

################################################################################
#####   argocd
################################################################################

# Route 53 > AWS ALB > Kubernetes Ingress > ClusterIP > Argo CD Server

module "argocd" {
  depends_on = [
    module.aws_load_balancer_controller
  ]

  source = "./modules/argocd"
  count  = var.argocd_enabled ? 1 : 0

  domain_name = "argocd.example.com"
  zone_id     = ""
}

################################################################################
#####   managed_prometheus_workspaces
################################################################################

# Might take 20 min or so to create. The Scraper takes a bit.

module "managed_prometheus_workspaces" {
  source   = "./modules/prometheus"
  for_each = var.prometheus_workspaces

  # aws_prometheus_workspace
  alias                 = each.key
  kms_key_arn           = each.value.kms_key_arn
  logging_configuration = each.value.logging_configuration

  # aws_prometheus_rule_group_namespace
  prometheus_rule_groups = each.value.prometheus_rule_groups

  # aws_prometheus_scraper
  scrape_configuration = each.value.scrape_configuration
  cluster_arn          = aws_eks_cluster.eks.arn
  subnet_ids           = local.subnet_ids
  security_group_ids   = local.security_group_ids 

  # aws_prometheus_alert_manager_definition
  alert_manager_definition = each.value.alert_manager_definition
}

################################################################################
#####   managed Grafana Workspaces
################################################################################