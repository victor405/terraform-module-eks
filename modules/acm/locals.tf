locals {
  subject_alternative_names = distinct(concat(
    ["*.${var.domain_name}"],
    var.subject_alternative_names
  ))
}