resource "aws_acm_certificate" "prod_cert" {
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = var.validation_method

  tags = var.prod_cert_tags

  lifecycle {
    create_before_destroy = true
  }
}