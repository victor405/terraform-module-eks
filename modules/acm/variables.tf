################################################################################
#####   aws_acm_certificate
################################################################################

variable "domain_name" {
  description = "(Required) Domain name for which the certificate should be issued"
}

variable "validation_method" {
  description = "(Required) Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform."
  default     = "DNS"
}

variable "subject_alternative_names" {
  description = "(Optional) Set of domains that should be SANs in the issued certificate. To remove all elements of a previously configured list, set this value equal to an empty list ([]) or use the terraform taint command to trigger recreation."
  default     = []
}

variable "key_algorithm" {
  description = "(Optional) The algorithm to use for the key. Either RSA_2048, RSA_1024, RSA_4096, EC_prime256v1, EC_secp384r1, or EC_secp521r1."
  default     = "RSA_2048"
}

variable "options_certificate_transparency_logging_preference" {
  description = "(Optional) Specifies whether a certificate should be added to a Certificate Transparency log. Valid values are ENABLED or DISABLED."
  default     = "ENABLED"
}


################################################################################
#####   aws_route53_record
################################################################################

variable "zone_ids" {
  description = "A map of domain names to Route 53 zone IDs."
  type        = map(string)
  default     = {}
}

variable "default_zone_id" {
  description = "The default Route 53 zone ID to use if a domain name is not found in the zone_ids map."
  type        = string
}
