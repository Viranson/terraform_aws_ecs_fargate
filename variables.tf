##Local Values
locals {
  aws_region     = "us-east-1"
  aws_account_id = "XXXXXXX"
  prefix         = "prod-eshop-ecs"
  common_tags = {
    Project      = local.prefix
    ManagedBy    = "Terraform"
    MaintainedBy = "Viranson HOUNNOUVI viransonland@gmail.com"
  }
  # vpc_cidr = var.vpc_cidr
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
  description = "AWS VPC resource variables set in map"
}

variable "vpc_subnets_profile" {
  # type        = map(any)
  description = "AWS VPC Subnets resources variables set in map"
}

variable "vpc_nat_eip_profile" {
  # type        = map(any)
  description = "AWS EIP variables set in map"
}

variable "vpc_igw_profile" {
  # type        = map(any)
  description = "AWS VPC Intenet Gateway variables set in map"
}

variable "vpc_natgw_profile" {
  # type        = map(any)
  description = "AWS VPC NAT Gateway variables set in map"
}

variable "vpc_route_table_profile" {
  # type        = map(any)
  description = "AWS VPC Route Tables resources variables set in map"
}

variable "vpc_route_table_assoc_profile" {
  # type        = map(any)
  description = "AWS VPC Route Tables Association resources variables set in map"
}

variable "vpc_sg_profile" {
  # type        = map(any)
  description = "AWS VPC Security Group resources variables set in map"
}

variable "ecs_cluster_profile" {
  # type        = map(any)
  description = "AWS ECS Cluster resources variables set in map"
}

variable "ecs_task_definition_profile" {
  # type        = map(any)
  description = "AWS ECS Cluster Task Definition resource variables set in map"
}

variable "vpc_sg_ecs_task_profile" {
  # type        = map(any)
  description = "AWS ECS TASK VPC Security Group resources variables set in map"
}

variable "ecs_alb_profile" {
  # type        = map(any)
  description = "AWS ECS ALB resources variables set in map"
}

variable "ecs_alb_target_group" {
  # type        = map(any)
  description = "AWS ECS ALB Target Group resources variables set in map"
}

variable "ecs_alb_listener" {
  # type        = map(any)
  description = "AWS ECS ALB Listener resources variables set in map"
}

variable "ecs_service" {
  # type        = map(any)
  description = "AWS ECS Service resources variables set in map"
}


##---------RESOURCES_VARS----------