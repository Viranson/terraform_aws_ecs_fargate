output "cf_dist_id" {
  value = aws_cloudfront_distribution.prod_cf_dist.id
}

output "cf_dist_dns_name" {
  value = aws_cloudfront_distribution.prod_cf_dist.domain_name
}