variable "app_autoscale_max_capacity" {
  type        = number
  description = "Max capacity of the scalable target"
}

variable "app_autoscale_min_capacity" {
  type        = number
  description = "Min capacity of the scalable target"
}

variable "ecs_cluster_name" {
  type        = string
  description = "ECS cluster name"
}

variable "ecs_service_name" {
  type        = string
  description = "ECS Service name"
}

variable "app_autoscale_scalable_dimension" {
  type        = string
  description = "Scalable dimension of the scalable target"
}

variable "app_autoscale_service_namespace" {
  type        = string
  description = "WS service namespace of the scalable target"
}