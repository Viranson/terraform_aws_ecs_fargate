module "aws_vpc" {
  source              = "./modules/aws_vpc"
  for_each            = var.vpc_profile
  vpc_ipv4_cidr_block = each.value.vpc_ipv4_cidr_block
  vpc_tags            = each.value.vpc_tags
}

module "aws_subnet" {
  source                 = "./modules/aws_subnets"
  for_each               = var.vpc_subnets_profile
  vpc_id                 = module.aws_vpc[each.value.vpc_name].vpc_id
  subnet_ipv4_cidr_block = each.value.subnet_ipv4_cidr_block
  az                     = each.value.az
  vpc_subnet_tags        = each.value.vpc_subnet_tags
}

module "aws_igw" {
  source       = "./modules/aws_vpc_igw"
  for_each     = var.vpc_igw_profile
  vpc_id       = module.aws_vpc[each.value.vpc_name].vpc_id
  aws_igw_tags = each.value.aws_igw_tags
}

module "aws_nat_eip" {
  source           = "./modules/aws_eip"
  for_each         = var.vpc_nat_eip_profile
  aws_nat_eip_tags = each.value.aws_nat_eip_tags
}

module "aws_natgw" {
  source            = "./modules/aws_vpc_natgw"
  for_each          = var.vpc_natgw_profile
  aws_vpc_subnet_id = module.aws_subnet[each.value.subnet_name].aws_subnet_id
  aws_eip_id        = module.aws_nat_eip[each.value.eip_name].aws_nat_eip_id
  vpc_natgw_tags    = each.value.aws_natgw_tags
}

module "aws_route_table" {
  source                          = "./modules/aws_vpc_route_tables"
  for_each                        = var.vpc_route_table_profile
  vpc_id                          = module.aws_vpc[each.value.vpc_name].vpc_id
  vpc_route_table_gateway_id      = each.value.scope == "public" ? module.aws_igw[each.value.vpc_igw_name].vpc_igw_id : module.aws_natgw[each.value.vpc_natgw_name].vpc_natgw_id
  vpc_route_table_ipv4_cidr_block = each.value.vpc_route_table_ipv4_cidr_block
  vpc_route_table_tags            = each.value.vpc_route_table_tags

}

module "aws_route_table_assoc" {
  source             = "./modules/aws_vpc_route_table_assoc"
  for_each           = var.vpc_route_table_assoc_profile
  aws_subnet_id      = module.aws_subnet[each.value.subnet_name].aws_subnet_id
  aws_route_table_id = module.aws_route_table[each.value.route_table_name].vpc_route_table_id

}

module "aws_security_group" {
  source        = "./modules/aws_security_group"
  for_each      = var.vpc_sg_profile
  vpc_id        = module.aws_vpc[each.value.vpc_name].vpc_id
  vpc_sg_name   = each.value.vpc_sg_name
  ingress_rules = each.value.ingress_rules
  vpc_sg_tags   = each.value.vpc_sg_tags
}

module "aws_security_group_ecs_task" {
  source      = "./modules/aws_security_group"
  for_each    = var.vpc_sg_ecs_task_profile
  vpc_id      = module.aws_vpc[each.value.vpc_name].vpc_id
  vpc_sg_name = each.value.vpc_sg_name
  ingress_rules = {
    allow_http_from_ecs_alb = {
      description      = "Allow HTTP From ECS ALB"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
    allow_any_from_ecs_alb = {
      description     = "Allow ANY"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      security_groups = ["${module.aws_security_group[each.value.alb_sg_name].vpc_sg_id}"]
    }
  }
  vpc_sg_tags = each.value.vpc_sg_tags
}

module "aws_ecs_cluster" {
  source                   = "./modules/aws_ecs_cluster"
  for_each                 = var.ecs_cluster_profile
  ecs_fargate_cluster_name = each.value.ecs_fargate_cluster_name
  ecs_fargate_cluster_tags = each.value.ecs_fargate_cluster_tags
}

module "aws_ecs_task_definition" {
  source                                       = "./modules/aws_ecs_task_definition"
  for_each                                     = var.ecs_task_definition_profile
  ecs_task_definition_family                   = each.value.ecs_task_definition_family
  ecs_task_definition_requires_compatibilities = each.value.ecs_task_definition_requires_compatibilities
  ecs_task_definition_network_mode             = each.value.ecs_task_definition_network_mode
  ecs_task_definition_execution_role_arn       = each.value.ecs_task_definition_execution_role_arn
  ecs_task_definition_memory                   = each.value.ecs_task_definition_memory
  ecs_task_definition_cpu                      = each.value.ecs_task_definition_cpu
  ecs_task_definition_container_definitions    = each.value.ecs_task_definition_container_definitions
  ecs_task_definition_tags                     = each.value.ecs_task_definition_tags
}

module "aws_lb" {
  source                     = "./modules/aws_lb"
  for_each                   = var.ecs_alb_profile
  load_balancer_name         = each.value.load_balancer_name
  internal                   = each.value.internal
  load_balancer_type         = each.value.load_balancer_type
  security_groups            = ["${module.aws_security_group[each.value.alb_sg_name].vpc_sg_id}"]
  subnets                    = ["${module.aws_subnet[each.value.subnets[0]].aws_subnet_id}", "${module.aws_subnet[each.value.subnets[1]].aws_subnet_id}"]
  enable_deletion_protection = each.value.enable_deletion_protection
  lb_tags                    = each.value.lb_tags
}

module "aws_alb_target_group" {
  source                = "./modules/aws_alb_target_group"
  for_each              = var.ecs_alb_target_group
  alb_target_group_name = each.value.alb_target_group_name
  port                  = each.value.port
  protocol              = each.value.protocol
  vpc_id                = module.aws_vpc[each.value.vpc_name].vpc_id
  target_type           = each.value.target_type
  health_check_points   = each.value.health_check_points
  alb_taget_group_tags  = each.value.alb_taget_group_tags
}

module "aws_alb_listener" {
  source            = "./modules/aws_alb_listener"
  for_each          = var.ecs_alb_listener
  load_balancer_id  = module.aws_lb[each.value.alb_name].lb_id
  port              = each.value.port
  protocol          = each.value.protocol
  target_group_arn  = module.aws_alb_target_group[each.value.alb_target_group_name].lb_target_group_arn
  type              = each.value.type
  alb_listener_tags = each.value.alb_listener_tags
}

module "aws_ecs_service" {
  source                 = "./modules/aws_ecs_service"
  for_each               = var.ecs_service
  ecs_fargate_cluster_id = module.aws_ecs_cluster[each.value.ecs_cluster_name].prod_ecs_fargate_cluster_id
  task_definition_arn    = module.aws_ecs_task_definition[each.value.ecs_task_definition_name].prod_ecs_task_definition_arn
  security_groups        = ["${module.aws_security_group[each.value.ecs_security_groups].vpc_sg_id}"]
  subnets                = ["${module.aws_subnet[each.value.subnets[0]].aws_subnet_id}", "${module.aws_subnet[each.value.subnets[1]].aws_subnet_id}"]
  target_group_arn       = module.aws_alb_target_group[each.value.target_group_name].lb_target_group_arn

  ecs_service_name                   = each.value.ecs_service_name
  desired_count                      = each.value.desired_count
  deployment_minimum_healthy_percent = each.value.deployment_minimum_healthy_percent
  deployment_maximum_percent         = each.value.deployment_maximum_percent
  launch_type                        = each.value.launch_type
  scheduling_strategy                = each.value.scheduling_strategy
  assign_public_ip                   = each.value.assign_public_ip
  container_name                     = each.value.container_name
  container_port                     = each.value.container_port
}

