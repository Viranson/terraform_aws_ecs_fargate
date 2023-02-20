resource "aws_ecs_task_definition" "prod_ecs_task_definition" {
  family                   = var.ecs_task_definition_family
  requires_compatibilities = var.ecs_task_definition_requires_compatibilities
  network_mode             = var.ecs_task_definition_network_mode
  execution_role_arn       = var.ecs_task_definition_execution_role_arn
  memory                   = var.ecs_task_definition_memory
  cpu                      = var.ecs_task_definition_cpu
  container_definitions    = var.ecs_task_definition_container_definitions
  tags                     = var.ecs_task_definition_tags
  volume {
    name = var.ecs_task_definition_volume_name
    efs_volume_configuration {
      file_system_id     = var.efs_id
      transit_encryption = var.transit_encryption
      root_directory     = var.root_directory #"/"
      authorization_config {
        iam = var.iam_auth
      }
    }
  }
}

resource "aws_iam_role" "prod_ecs_task_execution_role" {
  name = "prod-ecsTaskExecutionRole"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.prod_ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}