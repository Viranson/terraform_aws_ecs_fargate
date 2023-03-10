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

variable "vpc_rds_instance_sg_profile" {
  # type        = map(any)
  description = "AWS RDS VPC Security Group resources variables"
}

variable "vpc_efs_sg_profile" {
  # type        = map(any)
  description = "AWS EFS VPC Security Group resources variables"
}

variable "ecs_cluster_profile" {
  # type        = map(any)
  description = "AWS ECS Cluster resources variables"
}

# variable "efs_profile" {
#   # type        = map(any)
#   description = "AWS EFS resources variables"
# }

variable "efs_file_system_profile" {
  # type        = map(any)
  description = "AWS EFS File System resources variables"
}

variable "efs_mount_target_profile" {
  # type        = map(any)
  description = "AWS EFS Mount Target resources variables"
}

variable "efs_access_point_profile" {
  # type        = map(any)
  description = "AWS EFS Access Point resources variables"
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

variable "db_subnet_group_profile" {
  # type        = map(any)
  description = "AWS RDS Subnet Group Resource variables"
}

variable "db_instance_profile" {
  # type        = map(any)
  description = "AWS RDS Instance Resource variables"
}

variable "acm_certificate_profile" {
  # type        = map(any)
  description = "AWS ACS Certificate Resource variables"
}

variable "cloudfront_distribution_profile" {
  # type        = map(any)
  description = "AWS Coudfront Resource variables"
}


##---------RESOURCES_VARS----------