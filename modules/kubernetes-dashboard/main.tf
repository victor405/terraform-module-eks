################################################################################
#####   helm_release
################################################################################

resource "helm_release" "kubernetes_dashboard" {
  name             = "kubernetes-dashboard"
  namespace        = "kubernetes-dashboard"
  chart            = "kubernetes-dashboard"
  repository       = "https://kubernetes.github.io/dashboard/"
  version          = "5.0.4"
  create_namespace = true

  values = [
    yamlencode({
      service = {
        type         = "ClusterIP"
        externalPort = 443
      }

      resources = {
        limits = {
          cpu    = "100m"
          memory = "100Mi"
        }
        requests = {
          cpu    = "100m"
          memory = "100Mi"
        }
      }
    })
  ]
}


################################################################################
#####   aws_acm_cert
################################################################################

module "aws_acm_cert" {
  source = "../acm"

  domain_name     = var.domain_name
  default_zone_id = var.zone_id
}

################################################################################
#####   kubernetes_ingress_v1 dashboard_ingress AWS ALB
################################################################################

# All Subnets Require this tag for discoverability
# - kubernetes.io/role/elb = 1

resource "kubernetes_ingress_v1" "ingress" {
  depends_on = [
    helm_release.kubernetes_dashboard,
    module.aws_acm_cert
  ]

  metadata {
    name      = "kubernetes-dashboard-ingress"
    namespace = "kubernetes-dashboard"
    annotations = {
      "kubernetes.io/ingress.class"                   = "alb"
      "alb.ingress.kubernetes.io/scheme"              = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"         = "ip"
      "alb.ingress.kubernetes.io/listen-ports"        = "[{\"HTTP\":80}, {\"HTTPS\":443}]"
      "alb.ingress.kubernetes.io/certificate-arn"     = module.aws_acm_cert.acm_arn
      "alb.ingress.kubernetes.io/tags"                = "{\"Name\":\"kubernetes-dashboard\"}"
      "alb.ingress.kubernetes.io/healthcheck-path"    = "/"
      "alb.ingress.kubernetes.io/healthcheck-protocol"= "HTTPS"
      "alb.ingress.kubernetes.io/ssl-redirect"        = "443"
      "alb.ingress.kubernetes.io/backend-protocol"    = "HTTP"
      "alb.ingress.kubernetes.io/tags"                = "Name=kubernetes-dashboard"
    }
  }

  spec {
    rule {
      host = var.domain_name  # Your domain name

      http {
        path {
          path     = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "kubernetes-dashboard"
              port {
                number = 443
              }
            }
          }
        }
      }
    }
  }
}

################################################################################
#####   aws_route53_record for Kubernetes Dashboard
################################################################################

resource "aws_route53_record" "record" {
  depends_on = [kubernetes_ingress_v1.ingress]

  zone_id = var.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = data.aws_lb.alb.dns_name
    zone_id                = data.aws_lb.alb.zone_id
    evaluate_target_health = false
  }
}

