variable "ecs_fargate_cluster_name" {
  type        = string
  description = "Amazon ECS cluster name"
}

variable "ecs_fargate_cluster_tags" {
  type        = map(any)
  description = "AWS ECS Fargate Cluster Resource Tags"
}