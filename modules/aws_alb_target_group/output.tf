output "lb_target_group_id" {
  value = aws_alb_target_group.prod_alb_target_group.id
}

output "lb_target_group_arn" {
  value = aws_alb_target_group.prod_alb_target_group.arn
}