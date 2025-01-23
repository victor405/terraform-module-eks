################################################################################
#####   aws_acm_certificate
################################################################################

output "acm_id" {
  description = "ID of the certificate."
  value       = aws_acm_certificate.cert.id
}

output "acm_arn" {
  description = "ARN of the certificate."
  value       = aws_acm_certificate.cert.arn
}

output "acm_domain_name" {
  description = "Domain name for which the certificate is issued."
  value       = aws_acm_certificate.cert.domain_name
}

output "acm_domain_validation_options" {
  description = "Set of domain validation objects which can be used to complete certificate validation."
  value       = aws_acm_certificate.cert.domain_validation_options
}

output "acm_not_after" {
  description = "Expiration date and time of the certificate."
  value       = aws_acm_certificate.cert.not_after
}

output "acm_not_before" {
  description = "Start of the validity period of the certificate."
  value       = aws_acm_certificate.cert.not_before
}

output "acm_pending_renewal" {
  description = "Indicates if a private certificate eligible for managed renewal is within the early renewal duration period."
  value       = aws_acm_certificate.cert.pending_renewal
}

output "acm_renewal_eligibility" {
  description = "Whether the certificate is eligible for managed renewal."
  value       = aws_acm_certificate.cert.renewal_eligibility
}

output "acm_renewal_summary" {
  description = "Information about the status of ACM's managed renewal for the certificate."
  value       = aws_acm_certificate.cert.renewal_summary
}

output "acm_status" {
  description = "Status of the certificate."
  value       = aws_acm_certificate.cert.status
}

output "acm_type" {
  description = "Source of the certificate."
  value       = aws_acm_certificate.cert.type
}

output "acm_tags_all" {
  description = "Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = aws_acm_certificate.cert.tags_all
}

output "acm_validation_emails" {
  description = "List of email addresses that received a validation email. Only set if EMAIL validation was used."
  value       = aws_acm_certificate.cert.validation_emails
}

output "acm_domain_validation_objects" {
  description = "Details of domain validation objects including domain name, record name, type, and value."
  value = [
    for dvo in aws_acm_certificate.cert.domain_validation_options : {
      domain_name           = dvo.domain_name
      resource_record_name  = dvo.resource_record_name
      resource_record_type  = dvo.resource_record_type
      resource_record_value = dvo.resource_record_value
    }
  ]
}

output "acm_renewal_summary_objects" {
  description = "Details of renewal summary objects including renewal status and reason."
  value = [
    for rso in aws_acm_certificate.cert.renewal_summary : {
      renewal_status        = rso.renewal_status
      renewal_status_reason = rso.renewal_status_reason
    }
  ]
}


################################################################################
#####   aws_route53_record
################################################################################

output "route53_names" {
  description = "The names of the Route 53 records."
  value = {
    for k, v in aws_route53_record.records : k => v.name
  }
}

output "route53_fqdns" {
  description = "The FQDNs of the Route 53 records."
  value = {
    for k, v in aws_route53_record.records : k => v.fqdn
  }
}

################################################################################
#####   aws_acm_certificate_validation
################################################################################

output "certificate_validation_id" {
  description = "The ID of the ACM certificate validation resource."
  value       = aws_acm_certificate_validation.validation[0].id
}

output "certificate_arn" {
  description = "The ARN of the ACM certificate that is being validated."
  value       = aws_acm_certificate_validation.validation[0].certificate_arn
}

output "validation_record_fqdns" {
  description = "The FQDNs used to validate the ACM certificate."
  value       = aws_acm_certificate_validation.validation[0].validation_record_fqdns
}

