################################################################################
#####   Common
################################################################################

data "aws_vpc" "vpc" {
  count = var.vpc_id == null ? 1 : 0

  filter {
    name   = "tag:Name"
    values = ["aws-controltower*"]
  }
}

data "aws_subnets" "private_subnets" {
  count = var.subnet_ids == null ? 1 : 0

  filter {
    name   = "tag:Name"
    values = ["aws-controltower*"]
  }
  
  filter {
    name   = "tag:Network"
    values = ["Private"]
  }
}

data "aws_subnets" "public_subnets" {
  count = var.subnet_ids == null ? 1 : 0

  filter {
    name   = "tag:Name"
    values = ["aws-controltower*"]
  }
  
  filter {
    name   = "tag:Network"
    values = ["Public"]
  }
}

################################################################################
#####   aws_eks_cluster
################################################################################

data "aws_eks_cluster" "cluster" {
  name = local.cluster_name
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = aws_eks_cluster.eks.name
}

data "tls_certificate" "oidc_tls" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "oidc_iam_policy_document" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_eks_cluster.eks.identity[0].oidc[0].issuer, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.provider.arn]
      type        = "Federated"
    }
  }
}


################################################################################
#####   aws_eks_identity_provider_config
################################################################################

################################################################################
#####   aws_eks_access_policy_association
################################################################################

################################################################################
#####   aws_eks_access_entry
################################################################################

################################################################################
#####   aws_eks_node_group
################################################################################

################################################################################
#####   aws_eks_fargate_profile
################################################################################

################################################################################
#####   aws_eks_addon
################################################################################

################################################################################
#####   aws_eks_pod_identity_association
################################################################################