variable "domain_name" {
  type        = string
  description = "Domain name for which the certificate should be issued"
}

variable "subject_alternative_names" {
  type        = string
  description = "subdomains that should be SANs in the issued certificate"
}

variable "validation_method" {
  type        = string
  description = "Method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform"
}

variable "prod_cert_tags" {
  type        = map(any)
  description = "Tags to assign to the ressource"
}