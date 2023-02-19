resource "aws_ecs_cluster" "prod_ecs_fargate_cluster" {
  name = var.ecs_fargate_cluster_name
  tags = var.ecs_fargate_cluster_tags
}