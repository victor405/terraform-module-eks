################################################################################
#####   argocd
################################################################################

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true

  values = [
    yamlencode({
      server: {
        service: {
          type = "ClusterIP"
        }
      }
    })
  ]

  lifecycle {
    prevent_destroy = false
  }
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
#####   kubernetes_ingress_v1
################################################################################

resource "kubernetes_ingress_v1" "ingress" {
  depends_on = [
    helm_release.argocd,
    module.aws_acm_cert
  ]

  metadata {
    name      = "argocd-ingress"
    namespace = "argocd"
    annotations = {
      "kubernetes.io/ingress.class"                                 = "alb"
      "alb.ingress.kubernetes.io/scheme"                            = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"                       = "ip"
      "alb.ingress.kubernetes.io/certificate-arn"                   = module.aws_acm_cert.acm_arn
      "alb.ingress.kubernetes.io/listen-ports"                      = "[{\"HTTP\":80}, {\"HTTPS\":443}]"
      "alb.ingress.kubernetes.io/healthcheck-path"                  = "/healthz"
      "alb.ingress.kubernetes.io/healthcheck-protocol"              = "HTTPS"
      "alb.ingress.kubernetes.io/ssl-redirect"                      = "443"
      "alb.ingress.kubernetes.io/backend-protocol"                  = "HTTPS"
      "alb.ingress.kubernetes.io/backend-protocol-version.argogrpc" = "HTTP2"
      "alb.ingress.kubernetes.io/tags"                              = "Name=argocd"
      "alb.ingress.kubernetes.io/conditions.argogrpc"               = "[{\"field\":\"http-header\",\"httpHeaderConfig\":{\"httpHeaderName\": \"Content-Type\", \"values\":[\"application/grpc\"]}}]"
    }
  }

  spec {
    rule {
      host = var.domain_name

      http {
        # UI and API path
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "argocd-server"
              port {
                number = 443
              }
            }
          }
        }

        # gRPC path
        path {
          path      = "/grpc"
          path_type = "Prefix"

          backend {
            service {
              name = "argogrpc"
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
#####   kubernetes_service
################################################################################

resource "kubernetes_service" "argocd_server" {
  metadata {
    name      = "argocd-server"
    namespace = "argocd"
    labels = {
      app = "argocd-server"
    }
  }

  spec {
    selector = {
      "app.kubernetes.io/name" = "argocd-server"
    }
    port {
      port        = 443          # Exposes HTTPS
      target_port = 8080         # Maps to the internal port used by Argo CD
      protocol    = "TCP"
    }
    type = "ClusterIP"
  }
}


################################################################################
#####   aws_route53_record
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
