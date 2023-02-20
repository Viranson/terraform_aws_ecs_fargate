variable "ecs_service_name" {
  type        = string
  description = "Name of the service"
}

variable "ecs_fargate_cluster_id" {
  type        = string
  description = "ARN of an ECS cluster"
}

variable "task_definition_arn" {
  type        = string
  description = "Family and revision (family:revision) or full ARN of the task definition that you want to run in your service"
}

variable "desired_count" {
  type        = number
  description = "Number of instances of the task definition"
  # default = 2
}

variable "deployment_minimum_healthy_percent" {
  type        = number
  description = "Lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment"
  # default = 50
}

variable "deployment_maximum_percent" {
  type        = number
  description = "Upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment"
  # default = 200
}

# variable "platform_version" {
#     type = string
#     description = "Platform version on which to run your service. Only applicable for launch_type set to FARGATE"
#     default = "1.4.0"
# }

variable "launch_type" {
  type        = string
  description = "Launch type on which to run your service"
  # default = "FARGATE"
}

variable "scheduling_strategy" {
  type        = string
  description = "Scheduling strategy to use for the service"
  # default = "REPLICA"
}

variable "security_groups" {
  type        = list(any)
  description = "Security groups associated with the task or service"
}

variable "subnets" {
  type        = list(any)
  description = "Subnets associated with the task or service"
}

variable "assign_public_ip" {
  type        = bool
  description = "Assign a public IP address to the ENI (Fargate launch type only)"
  default     = false
}

variable "target_group_arn" {
  type        = string
  description = "ARN of the Load Balancer target group to associate with the service"
}

variable "container_name" {
  type        = string
  description = "Name of the container to associate with the load balancer (as it appears in a container definition)"
}

variable "container_port" {
  type        = number
  description = "Port on the container to associate with the load balancer"
}

variable "prod_ecs_service_tags" {
  type        = string
  description = "Resource Tags"
}