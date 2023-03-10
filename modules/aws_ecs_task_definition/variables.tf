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
}

variable "volume" {
  # type        = map
  description = "List of volumes"
}

variable "ecs_task_definition_tags" {
  type        = map(any)
  description = ""
}

# variable "efs_file_system_id" {
#   type        = string
#   description = "ID of the EFS File System"
# }

# variable "transit_encryption" {
#   type        = string
#   description = "Whether or not to enable encryption for Amazon EFS data in transit between the Amazon ECS host and the Amazon EFS server"
# }

# variable "root_directory" {
#   type        = string
#   description = "Directory within the Amazon EFS file system to mount as the root directory inside the host"
# }

# variable "iam_auth" {
#   type        = string
#   description = "Whether or not to use the Amazon ECS task IAM role defined in a task definition when mounting the Amazon EFS file system"
# }

