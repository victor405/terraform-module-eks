locals {

  # aws_prometheus_workspace
  kms_key_arn = var.kms_key_arn == "USE AWS Managed Key" ? null : null # aws_kms_key.kms[0].arn
  
  # aws_prometheus_rule_group_namespace
  
  # aws_prometheus_scraper
  prometheus_scraper_count = var.cluster_arn != null && var.subnet_ids != null ? 1 : 0
  scrape_configuration     = var.scrape_configuration != null ? var.scrape_configuration : data.aws_prometheus_default_scraper_configuration.default.configuration
  
  # aws_prometheus_alert_manager_definition

}
