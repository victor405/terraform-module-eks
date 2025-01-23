################################################################################
#####   aws_prometheus_workspace
################################################################################

output "prometheus_workspace_arn" {
  description = "Amazon Resource Name (ARN) of the Prometheus workspace"
  value       = aws_prometheus_workspace.prometheus.arn
}

output "prometheus_workspace_id" {
  description = "Identifier of the Prometheus workspace"
  value       = aws_prometheus_workspace.prometheus.id
}

output "prometheus_workspace_endpoint" {
  description = "Prometheus endpoint available for this workspace"
  value       = aws_prometheus_workspace.prometheus.prometheus_endpoint
}

output "prometheus_workspace_tags_all" {
  description = "A map of tags assigned to the Prometheus workspace, including inherited tags"
  value       = aws_prometheus_workspace.prometheus.tags_all
}


################################################################################
#####   aws_prometheus_rule_group_namespace
################################################################################

# None

################################################################################
#####   aws_prometheus_scraper
################################################################################

output "prometheus_scraper_arn" {
  description = "The Amazon Resource Name (ARN) of the Prometheus scraper"
  value       = aws_prometheus_scraper.prometheus[0].arn
}

output "prometheus_scraper_role_arn" {
  description = "The Amazon Resource Name (ARN) of the IAM role used by the Prometheus scraper"
  value       = aws_prometheus_scraper.prometheus[0].role_arn
}

# output "prometheus_scraper_status" {
#   description = "Status of the Prometheus scraper (ACTIVE, CREATING, DELETING, CREATION_FAILED, or DELETION_FAILED)"
#   value       = try(aws_prometheus_scraper.prometheus[0].status, null)
# }


################################################################################
#####   aws_prometheus_alert_manager_definition
################################################################################

# None