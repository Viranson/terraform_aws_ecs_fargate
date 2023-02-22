output "lb_id" {
  value = aws_lb.prod_alb.id
}

output "lb_arn" {
  value = aws_lb.prod_alb.arn
}

output "lb_dns_name" {
  value = aws_lb.prod_alb.dns_name
}