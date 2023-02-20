resource "aws_ecs_service" "prod_ecs_service" {
  name                               = var.ecs_service_name
  cluster                            = var.ecs_fargate_cluster_id
  task_definition                    = var.task_definition_arn
  desired_count                      = var.desired_count
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent
  #   platform_version                   = var.platform_version
  launch_type         = var.launch_type
  scheduling_strategy = var.scheduling_strategy
  network_configuration {
    security_groups  = var.security_groups
    subnets          = var.subnets
    assign_public_ip = var.assign_public_ip
  }
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
  tags = var.prod_ecs_service_tags
}