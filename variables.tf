##Local Values
locals {
  aws_region     = "us-east-1"
  aws_account_id = "012345678901"
  prefix         = "prod-eshop"
  common_tags = {
    Env           = "prod"
    Project       = local.prefix
    ManagedBy     = "Terraform"
    ProvisionedBy = "Terraform"
    Owner         = "viransonland@gmail.com"
  }

}

#Variables values defined in terraform.tfvars file
##---------CRDS----------
variable "region" {
  type        = string
  description = "AWS Region to provision resources"
}

variable "access_key" {
  type        = string
  description = "AWS Access Key"
}

variable "secret_key" {
  type        = string
  description = "AWS Secret Key"
}
##---------CRDS----------


##---------RESOURCES_VARS----------
variable "vpc_profile" {
  # type        = map(any)
  description = "AWS VPC resource variables"
}

variable "vpc_subnets_profile" {
  # type        = map(any)
  description = "AWS VPC Subnets resources variables"
}

variable "vpc_nat_eip_profile" {
  # type        = map(any)
  description = "AWS EIP variables"
}

variable "vpc_igw_profile" {
  # type        = map(any)
  description = "AWS VPC Intenet Gateway variables"
}

variable "vpc_natgw_profile" {
  # type        = map(any)
  description = "AWS VPC NAT Gateway variables"
}

variable "vpc_route_table_profile" {
  # type        = map(any)
  description = "AWS VPC Route Tables resources variables"
}

variable "vpc_route_table_assoc_profile" {
  # type        = map(any)
  description = "AWS VPC Route Tables Association resources variables"
}

variable "vpc_sg_profile" {
  # type        = map(any)
  description = "AWS VPC Security Group resources variables"
}

variable "ecs_cluster_profile" {
  # type        = map(any)
  description = "AWS ECS Cluster resources variables"
}

variable "efs_profile" {
  # type        = map(any)
  description = "AWS EFS resources variables"
}

variable "ecs_service_cloudwatch_log_group_profile" {
  # type        = map(any)
  description = "AWS CloudWatch Log Group Resource variables for ECS Service"
}

variable "ecs_task_definition_profile" {
  # type        = map(any)
  description = "AWS ECS Cluster Task Definition resource variables"
}

variable "vpc_sg_ecs_task_profile" {
  # type        = map(any)
  description = "AWS ECS TASK VPC Security Group resources variables"
}

variable "vpc_bastion_host_sg_profile" {
  # type        = map(any)
  description = "AWS EC2 Bastion Host Security Group resources variables"
}

variable "ecs_alb_profile" {
  # type        = map(any)
  description = "AWS ECS ALB resources variables"
}

variable "ecs_alb_target_group_profile" {
  # type        = map(any)
  description = "AWS ECS ALB Target Group resources variables"
}

variable "ecs_alb_listener_profile" {
  # type        = map(any)
  description = "AWS ECS ALB Listener resources variables"
}

variable "ecs_service_profile" {
  # type        = map(any)
  description = "AWS ECS Service resources variables"
}

variable "ecs_appautoscaling_target_profile" {
  # type        = map(any)
  description = "AWS Application AutoScaling ScalableTarget Resource variables"
}

variable "ec2_instance_profile" {
  # type        = map(any)
  description = "AWS EC2 Instance Resource variables"
}


##---------RESOURCES_VARS----------