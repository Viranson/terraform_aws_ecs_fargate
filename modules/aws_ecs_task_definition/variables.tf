variable "ecs_task_definition_family" {
  type        = string
  description = "Name of the ECS Task Definition"
}

variable "ecs_task_definition_requires_compatibilities" {
  type        = list(any)
  description = "ECS Task Definition Launch Type"
  # default     = ["FARGATE"]
}

variable "ecs_task_definition_network_mode" {
  type        = string
  description = "Docker networking mode to use for the containers in the task"
  # default     = "awsvpc"
}

variable "ecs_task_definition_execution_role_arn" {
  type        = string
  description = "ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume"
  # default = "arn:aws:iam::${local.aws_account_id}:role/ecsTaskExecutionRole"
}

variable "ecs_task_definition_memory" {
  type        = number
  description = "Amount (in MiB) of memory used by the task"
  # default     = 4096
}

variable "ecs_task_definition_cpu" {
  type        = number
  description = "Number of cpu units used by the task"
  # default     = 2048
}

variable "ecs_task_definition_container_definitions" {
  description = "A list of valid container definitions provided as a single valid JSON document"
  # default = jsonencode([
  #   {
  #     name      = "${local.image_name}"
  #     image     = "${local.image_name}:latest"
  #     cpu       = 1024
  #     memory    = 2048
  #     essential = true
  #     portMappings = [
  #       {
  #         containerPort = local.service_port
  #         hostPort      = local.service_port
  #       }
  #     ]
  #     environment = [
  #       {
  #         "name" : "WORDPRESS_DB_USER",
  #         "value" : var.wp_db_user
  #       },
  #       {
  #         "name" : "WORDPRESS_DB_HOST",
  #         "value" : var.wp_db_host
  #       },
  #       {
  #         "name" : "WORDPRESS_DB_PASSWORD",
  #         "value" : var.wp_db_password
  #       },
  #       {
  #         "name" : "WORDPRESS_DB_NAME",
  #         "value" : var.wp_db_name
  #       }
  #     ]
  #   }
  # ])
}

variable "ecs_task_definition_tags" {
  type        = map(any)
  description = ""
  # default = merge(
  #   local.common_tags,
  #   {
  #     Name = local.task_def_name
  #   }
  # )
}