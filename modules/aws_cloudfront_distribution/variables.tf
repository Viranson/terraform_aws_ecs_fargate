variable "enabled" {
  type        = bool
  description = "Specify whether the distribution is enabled to accept end user requests for content."
}

variable "domain_name_aliases" {
  type        = list(any)
  description = "Extra CNAMEs (alternate domain names), if any, for this distribution"
}

variable "origin" {
  description = "One or more origins for this distribution (multiples allowed)"
}

variable "default_cache_behavior" {
  description = " Default cache behavior for this distribution (maximum one)"
}

variable "restriction_type" {
  type        = string
  description = "Method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist"
}

variable "locations" {
  type        = list(any)
  description = "ISO 3166-1-alpha-2 codes for which CloudFront either distribute content (whitelist) or not distribute content (blacklist). If the type is specified as none an empty array can be used"
}

variable "acm_certificate_arn" {
  type        = string
  description = "ARN of the AWS Certificate Manager certificate that you wish to use with this distribution"
}

variable "ssl_support_method" {
  type        = string
  description = "Specify how CloudFront serve HTTPS requests."
}

variable "minimum_protocol_version" {
  type        = string
  description = "Minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections"
}

variable "prod_cf_dist_tags" {
  type        = map(any)
  description = "Tags to assign to Resource"
}