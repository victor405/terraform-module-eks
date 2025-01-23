resource "aws_acm_certificate" "cert" {
  domain_name               = var.domain_name
  validation_method         = var.validation_method
  subject_alternative_names = local.subject_alternative_names
  key_algorithm             = var.key_algorithm

  options {
    certificate_transparency_logging_preference = var.options_certificate_transparency_logging_preference
  }

  tags = {
    Name              = var.domain_name
    validation_method = var.validation_method
  }

  lifecycle {
    create_before_destroy =  true
    ignore_changes        = [subject_alternative_names]
  }
}

resource "aws_route53_record" "records" {
  #provider = aws.primary
  for_each = var.validation_method == "DNS" ? {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = lookup(var.zone_ids, dvo.domain_name, var.default_zone_id)
    }
  } : {}

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = each.value.zone_id
}

resource "aws_acm_certificate_validation" "validation" {
  count                   = var.validation_method == "DNS" ? 1 : 0
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.records : record.fqdn]
}