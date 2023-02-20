output "ecs_service_id" {
  value = aws_ecs_service.prod_ecs_service.id
}

output "ecs_service_name" {
  value = aws_ecs_service.prod_ecs_service.name
}