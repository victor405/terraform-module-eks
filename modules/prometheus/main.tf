################################################################################
#####   aws_prometheus_workspace
################################################################################

resource "aws_prometheus_workspace" "prometheus" {
  alias       = var.alias
  kms_key_arn = local.kms_key_arn

  dynamic "logging_configuration" {
    for_each = var.logging_configuration

    content {
      log_group_arn = logging_configuration.value.log_group_arn
    }
  }

  tags = {
    Name  = var.alias
    alias = var.alias
    tech  = "aws-managed-prometheus"
  }
}

resource "aws_kms_key" "kms" {
  count       = var.kms_key_arn == null ? 1 : 0
  description = "AWS KMS Key"
}

resource "aws_kms_alias" "kms_alias" {
  count         = var.kms_key_arn == null ? 1 : 0
  name          = "alias/${var.alias}-prometheus-key"
  target_key_id = aws_kms_key.kms[0].key_id
}

################################################################################
#####   aws_prometheus_rule_group_namespace
################################################################################

resource "aws_prometheus_rule_group_namespace" "prometheus" {
  for_each     = var.prometheus_rule_groups
  name         = each.key
  workspace_id = aws_prometheus_workspace.prometheus.id
  data         = each.value.data
}

################################################################################
#####   aws_prometheus_scraper
################################################################################

resource "aws_prometheus_scraper" "prometheus" {
  count = local.prometheus_scraper_count

  destination {
    amp {
      workspace_arn = aws_prometheus_workspace.prometheus.arn
    }
  }

  scrape_configuration = local.scrape_configuration

  source {
    eks {
      cluster_arn        = var.cluster_arn
      subnet_ids         = var.subnet_ids
      security_group_ids = var.security_group_ids
    }
  }
}

################################################################################
#####   aws_prometheus_alert_manager_definition
################################################################################

resource "aws_prometheus_alert_manager_definition" "prometheus" {
  count        = var.alert_manager_definition != null ? 1 : 0
  workspace_id = aws_prometheus_workspace.prometheus.arn
  definition   = var.alert_manager_definition
}