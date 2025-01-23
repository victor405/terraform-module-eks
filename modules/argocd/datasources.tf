data "aws_lbs" "albs" {
  depends_on = [kubernetes_ingress_v1.ingress]

  tags = {
    "Name" = "argocd"
  }
}

data "aws_lb" "alb" {
  depends_on = [kubernetes_ingress_v1.ingress]
  arn        = tolist(data.aws_lbs.albs.arns)[0]
}