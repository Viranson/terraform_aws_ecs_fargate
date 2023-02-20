output "appautoscaling_target_id" {
  value = aws_appautoscaling_target.prod_ecs_svc_autoscaling_target.id
}

output "appautoscaling_target_arn" {
  value = aws_appautoscaling_target.prod_ecs_svc_autoscaling_target.arn
}