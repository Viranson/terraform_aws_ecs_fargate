module "aws_vpc" {
  source              = "./modules/aws_vpc"
  for_each            = var.vpc_profile
  vpc_ipv4_cidr_block = each.value.vpc_ipv4_cidr_block
  vpc_tags = merge(
    local.common_tags, each.value.tags
  )
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
  description   = each.value.description
  ingress_rules = each.value.ingress_rules
  egress_rules  = each.value.egress_rules
  vpc_sg_tags = merge(
    local.common_tags, each.value.tags
  )
}

module "aws_security_group_ecs_task" {
  source      = "./modules/aws_security_group"
  for_each    = var.vpc_sg_ecs_task_profile
  vpc_id      = module.aws_vpc[each.value.vpc_name].vpc_id
  vpc_sg_name = each.value.vpc_sg_name
  description = each.value.description
  ingress_rules = {
    allow_http_from_anywhere = {
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
  egress_rules = {
    allow_all_from_anywhere = {
      description      = "Allow All"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  vpc_sg_tags = merge(
    local.common_tags, each.value.tags
  )
}

module "aws_security_group_bastion" {
  source      = "./modules/aws_security_group"
  for_each    = var.vpc_bastion_host_sg_profile
  vpc_id      = module.aws_vpc[each.value.vpc_name].vpc_id
  vpc_sg_name = each.value.vpc_sg_name
  description = each.value.description
  ingress_rules = {
    allow_ssh_from_anywhere = {
      description      = "Allow SSH From Anywhere"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  egress_rules = {
    allow_https_to_anywhere = {
      description      = "Allow HTTPS to Anywhere"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
    allow_http_to_anywhere = {
      description      = "Allow HTTP to Anywhere"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
    allow_mysql_to_data_private_subnets = {
      description = "Allow MySQL to Database Private Subnet"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = [
        "${module.aws_subnet[each.value.subnets[0]].aws_subnet_cidr_block}",
        "${module.aws_subnet[each.value.subnets[1]].aws_subnet_cidr_block}"
      ]
    }
    allow_efs_to_app_private_subnets = {
      description = "Allow MySQL to Database Private Subnet"
      from_port   = 2049
      to_port     = 2049
      protocol    = "tcp"
      cidr_blocks = [
        "${module.aws_subnet[each.value.subnets[2]].aws_subnet_cidr_block}",
        "${module.aws_subnet[each.value.subnets[3]].aws_subnet_cidr_block}"
      ]
    }
  }
  vpc_sg_tags = merge(
    local.common_tags, each.value.tags
  )
}

module "aws_security_group_rds" {
  source      = "./modules/aws_security_group"
  for_each    = var.vpc_rds_instance_sg_profile
  vpc_id      = module.aws_vpc[each.value.vpc_name].vpc_id
  vpc_sg_name = each.value.vpc_sg_name
  description = each.value.description
  ingress_rules = {
    allow_mysql = {
      description = "Allow MySQL connexion From ECS services and Bastion Host"
      protocol    = "tcp"
      from_port   = 3306
      to_port     = 3306

      security_groups = [
        "${module.aws_security_group_bastion[each.value.security_groups[0]].vpc_sg_id}",
        "${module.aws_security_group_ecs_task[each.value.security_groups[1]].vpc_sg_id}"
      ]
    }
  }
  egress_rules = {
    allow_all_to_anywhere = {
      description      = "Allow All"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  vpc_sg_tags = merge(
    local.common_tags, each.value.tags
  )
}

module "aws_security_group_efs" {
  source      = "./modules/aws_security_group"
  for_each    = var.vpc_efs_sg_profile
  vpc_id      = module.aws_vpc[each.value.vpc_name].vpc_id
  vpc_sg_name = each.value.vpc_sg_name
  description = each.value.description
  ingress_rules = {
    allow_efs = {
      description = "Allow EFS connexion From ECS services subnets"
      protocol    = "tcp"
      from_port   = 2049
      to_port     = 2049

      cidr_blocks = [
        "${module.aws_subnet[each.value.subnets[0]].aws_subnet_cidr_block}",
        "${module.aws_subnet[each.value.subnets[1]].aws_subnet_cidr_block}"
      ]
    }
    allow_efs = {
      description = "Allow EFS connexion From ECS services and Bastion Host SG"
      protocol    = "tcp"
      from_port   = 2049
      to_port     = 2049

      security_groups = [
        "${module.aws_security_group_bastion[each.value.security_groups[0]].vpc_sg_id}",
        "${module.aws_security_group_ecs_task[each.value.security_groups[1]].vpc_sg_id}"
      ]
    }
  }
  egress_rules = {
    allow_all = {
      description = "Allow All to ECS services subnets"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [
        "${module.aws_subnet[each.value.subnets[0]].aws_subnet_cidr_block}",
        "${module.aws_subnet[each.value.subnets[1]].aws_subnet_cidr_block}"
      ]
    }
    allow_all_to_anywhere = {
      description = "Allow All to ECS services and Bastion Host SG"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      security_groups = [
        "${module.aws_security_group_bastion[each.value.security_groups[0]].vpc_sg_id}",
        "${module.aws_security_group_ecs_task[each.value.security_groups[1]].vpc_sg_id}"
      ]
    }
  }
  vpc_sg_tags = merge(
    local.common_tags, each.value.tags
  )
}

module "aws_ecs_cluster" {
  source                   = "./modules/aws_ecs_cluster"
  for_each                 = var.ecs_cluster_profile
  ecs_fargate_cluster_name = each.value.ecs_fargate_cluster_name
  ecs_fargate_cluster_tags = merge(
    local.common_tags, each.value.tags
  )
}

# module "aws_efs" {
#   source       = "./modules/aws_efs"
#   for_each     = var.efs_profile
#   name         = each.value.efs_name
#   vpc_id       = module.aws_vpc[each.value.vpc_name].vpc_id
#   subnet_ids   = ["${module.aws_subnet[each.value.subnets[0]].aws_subnet_id}", "${module.aws_subnet[each.value.subnets[1]].aws_subnet_id}"]
#   whitelist_sg = ["${module.aws_security_group_ecs_task[each.value.ecs_task_security_group].vpc_sg_id}"]
#   port         = each.value.port
# }

module "aws_efs_file_system" {
  source           = "./modules/aws_efs_file_system"
  for_each         = var.efs_file_system_profile
  efs_storage_name = each.value.efs_storage_name
  performance_mode = each.value.performance_mode
  throughput_mode  = each.throughput_mode
  encrypted        = each.value.encrypted
  prod_efs_storage_tags = merge(
    local.common_tags, each.value.tags
  )
}

module "aws_efs_mount_target" {
  source         = "./modules/aws_efs_mount_target"
  for_each       = var.efs_mount_target_profile
  file_system_id = module.aws_efs_file_system[each.value.efs_name].efs_id
  subnet_id      = module.aws_subnet[each.value.subnet_name].aws_subnet_id
  vpc_sg_ids     = ["${module.aws_security_group[each.value.security_groups[0]].vpc_sg_id}"]
}

module "aws_efs_access_point" {
  source                = "./modules/aws_efs_access_point"
  for_each              = var.efs_access_point_profile
  file_system_id        = module.aws_efs_file_system[each.value.efs_name].efs_id
  root_path             = each.value.root_path
  owner_gid             = each.value.owner_gid
  owner_uid             = each.value.owner_uid
  root_path_permissions = each.value.root_path_permissions
  efs_access_point_tags = merge(
    local.common_tags, each.value.tags
  )
}

module "aws_cloudwatch_log_group" {
  source            = "./modules/aws_cloudwatch_log_group"
  for_each          = var.ecs_service_cloudwatch_log_group_profile
  cw_log_group_name = each.value.cw_log_group_name
  retention_in_days = each.value.retention_in_days
  cw_log_group_tags = merge(
    local.common_tags, each.value.tags
  )
}

module "aws_ecs_task_definition" {
  source                                       = "./modules/aws_ecs_task_definition"
  for_each                                     = var.ecs_task_definition_profile
  ecs_task_definition_family                   = each.value.ecs_task_definition_family
  ecs_task_definition_requires_compatibilities = each.value.ecs_task_definition_requires_compatibilities
  ecs_task_definition_network_mode             = each.value.ecs_task_definition_network_mode
  ecs_task_definition_execution_role_arn       = "arn:aws:iam::${local.aws_account_id}:role/ecsTaskExecutionRole"
  ecs_task_definition_memory                   = each.value.ecs_task_definition_memory
  ecs_task_definition_cpu                      = each.value.ecs_task_definition_cpu
  ecs_task_definition_container_definitions = jsonencode([
    {
      name      = "prestashop"
      image     = "prestashop/prestashop"
      cpu       = 1024
      memory    = 2048
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "${module.aws_cloudwatch_log_group[each.value.log_group_name].prod_cw_log_group_name}"
          awslogs-region        = local.aws_region
          awslogs-stream-prefix = "prod-eshop"
        }
      }
      environment = [
        {
          "name" : "DB_USER",
          "value" : "var.db_user"
        },
        {
          "name" : "DB_SERVER",
          "value" : "${module.aws_db_instance[each.value.db_instance_name].prod_db_host}"
        },
        {
          "name" : "DB_PASSWD",
          "value" : "var.db_password"
        },
        {
          "name" : "PS_DOMAIN",
          "value" : "var.domain"
        },
        {
          "name" : "PS_FOLDER_ADMIN",
          "value" : "var.admin_folder"
        },
        {
          "name" : "ADMIN_MAIL",
          "value" : "var.admin_email"
        },
        {
          "name" : "ADMIN_PASSWD",
          "value" : "var.admin_passwd"
        }
      ]
      mountPoints = [
        {
          "readOnly" : null,
          "containerPath" : "/var/www/html/img/",
          "sourceVolume" : "ImgEFS"
        },
        {
          "readOnly" : null,
          "containerPath" : "/var/www/html/modules/",
          "sourceVolume" : "ModulesEFS"
        },
        {
          "readOnly" : null,
          "containerPath" : "/var/www/html/themes/",
          "sourceVolume" : "ThemesEFS"
        },
        {
          "readOnly" : null,
          "containerPath" : "/var/www/html/var/",
          "sourceVolume" : "VarEFS"
        },
        {
          "readOnly" : null,
          "containerPath" : "/var/www/html/config/",
          "sourceVolume" : "ConfigEFS"
        },
        {
          "readOnly" : null,
          "containerPath" : "/var/www/html/override/",
          "sourceVolume" : "OverrideEFS"
        },
        {
          "readOnly" : null,
          "containerPath" : "/var/www/html/download/",
          "sourceVolume" : "DownloadEFS"
        },
        {
          "readOnly" : null,
          "containerPath" : "/var/www/html/upload/",
          "sourceVolume" : "UploadEFS"
        }
      ]
    }
  ])
  volume = [
    {
      source_volume = "ImgEFS"
      efs_volume_configuration = [
        {
          efs_file_system_id = module.aws_efs_file_system[each.value.efs_name].efs_id
          transit_encryption = "ENABLED"
          root_directory     = "/eshop/prod/img/"
          authorization_config = [
            {
              access_point_id = module.aws_efs_access_point[each.value.access_point_img].prod_efs_access_point_id
              iam             = "ENABLED"
            }
          ]
        }
      ]
    },
    {
      source_volume = "ModulesEFS"
      efs_volume_configuration = [
        {
          efs_file_system_id = module.aws_efs_file_system[each.value.efs_name].efs_id
          transit_encryption = "ENABLED"
          root_directory     = "/eshop/prod/modules/"
          authorization_config = [
            {
              access_point_id = module.aws_efs_access_point[each.value.access_point_modules].prod_efs_access_point_id
              iam             = "ENABLED"
            }
          ]
        }
      ]
    },
    {
      source_volume = "ThemesEFS"
      efs_volume_configuration = [
        {
          efs_file_system_id = module.aws_efs_file_system[each.value.efs_name].efs_id
          transit_encryption = "ENABLED"
          root_directory     = "/eshop/prod/themes/"
          authorization_config = [
            {
              access_point_id = module.aws_efs_access_point[each.value.access_point_themes].prod_efs_access_point_id
              iam             = "ENABLED"
            }
          ]
        }
      ]
    },
    {
      source_volume = "VarEFS"
      efs_volume_configuration = [
        {
          efs_file_system_id = module.aws_efs_file_system[each.value.efs_name].efs_id
          transit_encryption = "ENABLED"
          root_directory     = "/eshop/prod/var/"
          authorization_config = [
            {
              access_point_id = module.aws_efs_access_point[each.value.access_point_var].prod_efs_access_point_id
              iam             = "ENABLED"
            }
          ]
        }
      ]
    },
    {
      source_volume = "ConfigEFS"
      efs_volume_configuration = [
        {
          efs_file_system_id = module.aws_efs_file_system[each.value.efs_name].efs_id
          transit_encryption = "ENABLED"
          root_directory     = "/eshop/prod/config/"
          authorization_config = [
            {
              access_point_id = module.aws_efs_access_point[each.value.access_point_config].prod_efs_access_point_id
              iam             = "ENABLED"
            }
          ]
        }
      ]
    },
    {
      source_volume = "OverrideEFS"
      efs_volume_configuration = [
        {
          efs_file_system_id = module.aws_efs_file_system[each.value.efs_name].efs_id
          transit_encryption = "ENABLED"
          root_directory     = "/eshop/prod/override/"
          authorization_config = [
            {
              access_point_id = module.aws_efs_access_point[each.value.access_point_override].prod_efs_access_point_id
              iam             = "ENABLED"
            }
          ]
        }
      ]
    },
    {
      source_volume = "DownloadEFS"
      efs_volume_configuration = [
        {
          efs_file_system_id = module.aws_efs_file_system[each.value.efs_name].efs_id
          transit_encryption = "ENABLED"
          root_directory     = "/eshop/prod/download/"
          authorization_config = [
            {
              access_point_id = module.aws_efs_access_point[each.value.access_point_download].prod_efs_access_point_id
              iam             = "ENABLED"
            }
          ]
        }
      ]
    },
    {
      source_volume = "UploadEFS"
      efs_volume_configuration = [
        {
          efs_file_system_id = module.aws_efs_file_system[each.value.efs_name].efs_id
          transit_encryption = "ENABLED"
          root_directory     = "/eshop/prod/upload/"
          authorization_config = [
            {
              access_point_id = module.aws_efs_access_point[each.value.access_point_upload].prod_efs_access_point_id
              iam             = "ENABLED"
            }
          ]
        }
      ]
    }
  ]

  # ecs_task_definition_volume_name = each.value.ecs_task_definition_volume_name
  # efs_id                          = module.aws_efs_file_system[each.value.efs_name].efs_id
  # transit_encryption              = each.value.transit_encryption
  # root_directory                  = each.value.root_directory
  # iam_auth                        = each.value.iam_auth
  ecs_task_definition_tags = merge(
    local.common_tags, each.value.tags
  )
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
  lb_tags = merge(
    local.common_tags, each.value.tags
  )
}

module "aws_alb_target_group" {
  source                = "./modules/aws_alb_target_group"
  for_each              = var.ecs_alb_target_group_profile
  alb_target_group_name = each.value.alb_target_group_name
  port                  = each.value.port
  protocol              = each.value.protocol
  vpc_id                = module.aws_vpc[each.value.vpc_name].vpc_id
  target_type           = each.value.target_type
  health_check_points   = each.value.health_check_points
  alb_taget_group_tags = merge(
    local.common_tags, each.value.tags
  )
}

module "aws_alb_listener" {
  source            = "./modules/aws_alb_listener"
  for_each          = var.ecs_alb_listener_profile
  load_balancer_arn = module.aws_lb[each.value.alb_name].lb_arn
  port              = each.value.port
  protocol          = each.value.protocol
  target_group_arn  = module.aws_alb_target_group[each.value.alb_target_group_name].lb_target_group_arn
  type              = each.value.type
  certificate_arn   = module.aws_acm_certificate[each.value.acm_cert_name].prod_cert_arn
  alb_listener_tags = merge(
    local.common_tags, each.value.tags
  )
}

module "aws_ecs_service" {
  source                 = "./modules/aws_ecs_service"
  for_each               = var.ecs_service_profile
  ecs_fargate_cluster_id = module.aws_ecs_cluster[each.value.ecs_cluster_name].prod_ecs_fargate_cluster_id
  task_definition_arn    = module.aws_ecs_task_definition[each.value.ecs_task_definition_name].prod_ecs_task_definition_arn
  security_groups        = ["${module.aws_security_group_ecs_task[each.value.ecs_task_security_group].vpc_sg_id}"]
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
  prod_ecs_service_tags = merge(
    local.common_tags, each.value.tags
  )
}

module "aws_appautoscaling_target" {
  source           = "./modules/aws_appautoscaling_target"
  for_each         = var.ecs_appautoscaling_target_profile
  ecs_cluster_name = module.aws_ecs_cluster[each.value.ecs_cluster_name].prod_ecs_fargate_cluster_name
  ecs_service_name = module.aws_ecs_service[each.value.ecs_service_name].ecs_service_name

  app_autoscale_max_capacity       = each.value.app_autoscale_max_capacity
  app_autoscale_min_capacity       = each.value.app_autoscale_min_capacity
  app_autoscale_scalable_dimension = each.value.app_autoscale_scalable_dimension
  app_autoscale_service_namespace  = each.value.app_autoscale_service_namespace
}

module "aws_iam_bastion_host_profile" {
  source = "./modules/aws_iam_instance_bastion_profile"
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

module "aws_instance" {
  source                    = "./modules/aws_instance"
  for_each                  = var.ec2_instance_profile
  ec2_ami                   = data.aws_ami.amazon_linux.id
  user_data                 = each.value.user_data
  instance_type             = each.value.instance_type
  iam_instance_profile_name = module.aws_iam_bastion_host_profile.bastion_iam_instance_profile_name
  key_name                  = each.value.key_name
  subnet_id                 = module.aws_subnet[each.value.subnet_name].aws_subnet_id
  security_group_ids        = ["${module.aws_security_group_bastion[each.value.vpc_sg_name].vpc_sg_id}"]
  prod_ec2_instance_tags = merge(
    local.common_tags, each.value.tags
  )
}

module "aws_db_subnet_group" {
  source               = "./modules/aws_db_subnet_group"
  for_each             = var.db_subnet_group_profile
  db_subnet_group_name = each.value.db_subnet_group_name
  subnet_ids = [
    "${module.aws_subnet[each.value.subnets[0]].aws_subnet_id}",
    "${module.aws_subnet[each.value.subnets[1]].aws_subnet_id}"
  ]
  prod_db_subnet_group_tags = merge(
    local.common_tags, each.value.tags
  )
}

module "aws_db_instance" {
  source                     = "./modules/aws_db_instance"
  for_each                   = var.db_instance_profile
  db_instance_identifier     = each.value.db_instance_identifier
  db_name                    = each.value.db_name
  allocated_storage          = 20
  db_storage_type            = each.value.db_storage_type
  db_engine                  = each.value.db_engine
  db_engine_version          = each.value.db_engine_version
  db_instance_class          = each.value.db_instance_class
  db_subnet_group_name       = module.aws_db_subnet_group[each.value.db_subnet_group_name].prod_db_subnet_group_name
  db_password                = each.value.db_password
  db_username                = each.value.db_username
  db_backup_retention_period = each.value.db_backup_retention_period
  db_multi_az                = each.value.db_multi_az
  db_skip_final_snapshot     = each.value.db_skip_final_snapshot
  db_vpc_security_group_ids = [
    "${module.aws_security_group_rds[each.value.security_groups[0]].vpc_sg_id}"
  ]

  prod_db_instance_tags = merge(
    local.common_tags, each.value.tags
  )
}

module "aws_acm_certificate" {
  source                    = "./modules/aws_acm_certificate"
  for_each                  = var.acm_certificate_profile
  domain_name               = each.value.domain_name
  subject_alternative_names = each.value.subject_alternative_names
  validation_method         = each.value.validation_method
  prod_cert_tags = merge(
    local.common_tags, each.value.tags
  )
}