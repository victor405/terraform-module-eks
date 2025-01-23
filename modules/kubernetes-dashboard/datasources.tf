data "aws_lbs" "albs" {
  depends_on = [kubernetes_ingress_v1.ingress]

  tags = {
    "Name" = "kubernetes-dashboard"
  }
}

data "aws_lb" "alb" {
  depends_on = [kubernetes_ingress_v1.ingress]
  arn        = tolist(data.aws_lbs.albs.arns)[0]
}