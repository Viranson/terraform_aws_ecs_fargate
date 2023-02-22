region     = "us-east-1"
access_key = ""
secret_key = ""

# = "prod_eshop

vpc_profile = {
  prod-vpc01 = {
    vpc_ipv4_cidr_block = "10.200.0.0/16"
    tags = {
      Name = "prod-vpc01"
    }
  }
}

vpc_subnets_profile = {
  public-us-east-1a = {
    vpc_name               = "prod-vpc01"
    az                     = "us-east-1a"
    subnet_ipv4_cidr_block = "10.200.1.0/24"
    vpc_subnet_tags = {
      Name = "public-us-east-1a-prod"
    }
  }

  public-us-east-1b = {
    vpc_name               = "prod-vpc01"
    az                     = "us-east-1b"
    subnet_ipv4_cidr_block = "10.200.3.0/24"
    vpc_subnet_tags = {
      Name = "public-us-east-1b-prod"
    }
  }

  private-us-east-1a-app = {
    vpc_name               = "prod-vpc01"
    az                     = "us-east-1a"
    subnet_ipv4_cidr_block = "10.200.0.0/24"
    vpc_subnet_tags = {
      Name = "private-us-east-1a-app-prod"
    }
  }

  private-us-east-1b-app = {
    vpc_name               = "prod-vpc01"
    az                     = "us-east-1b"
    subnet_ipv4_cidr_block = "10.200.2.0/24"
    vpc_subnet_tags = {
      Name = "private-us-east-1b-app-prod"
    }
  }

  private-us-east-1a-data = {
    vpc_name               = "prod-vpc01"
    az                     = "us-east-1a"
    subnet_ipv4_cidr_block = "10.200.4.0/24"
    vpc_subnet_tags = {
      Name = "private-us-east-1a-data-prod"
    }
  }

  private-us-east-1b-data = {
    vpc_name               = "prod-vpc01"
    az                     = "us-east-1b"
    subnet_ipv4_cidr_block = "10.200.6.0/24"
    vpc_subnet_tags = {
      Name = "private-us-east-1b-data-prod"
    }
  }
}

vpc_nat_eip_profile = {
  prod-vpc01-natgw_eip_01 = {
    vpc_name = "prod-vpc01"
    aws_nat_eip_tags = {
      Name = "prod-vpc01-natgw-eip"
    }
  }
}

vpc_igw_profile = {
  prod-vpc01-igw = {
    vpc_name = "prod-vpc01"
    aws_igw_tags = {
      Name = "prod-vpc01-igw"
    }
  }
}

vpc_natgw_profile = {
  prod-vpc01-natgw-01 = {
    vpc_name    = "prod-vpc01"
    subnet_name = "public-us-east-1a"
    eip_name    = "prod-vpc01-natgw_eip_01"
    aws_natgw_tags = {
      Name = "prod-vpc01-natgw"
    }
  }
}

vpc_route_table_profile = {
  public-route-table = {
    scope                           = "public"
    vpc_name                        = "prod-vpc01"
    vpc_igw_name                    = "prod-vpc01-igw"
    vpc_route_table_ipv4_cidr_block = "0.0.0.0/0"
    vpc_route_table_tags = {
      Name = "public-route-table-prod"
    }
  }

  private-route-table-01 = {
    scope                           = "private"
    vpc_name                        = "prod-vpc01"
    vpc_natgw_name                  = "prod-vpc01-natgw-01"
    vpc_route_table_ipv4_cidr_block = "0.0.0.0/0"
    vpc_route_table_tags = {
      Name = "private-route-table-prod"
    }
  }

  private-route-table-02 = {
    scope                           = "private"
    vpc_name                        = "prod-vpc01"
    vpc_natgw_name                  = "prod-vpc01-natgw-01"
    vpc_route_table_ipv4_cidr_block = "0.0.0.0/0"
    vpc_route_table_tags = {
      Name = "private-route-table-prod"
    }
  }

  private-route-table-03 = {
    scope                           = "private"
    vpc_name                        = "prod-vpc01"
    vpc_natgw_name                  = "prod-vpc01-natgw-01"
    vpc_route_table_ipv4_cidr_block = "0.0.0.0/0"
    vpc_route_table_tags = {
      Name = "private-route-table-prod"
    }
  }

  private-route-table-04 = {
    scope                           = "private"
    vpc_name                        = "prod-vpc01"
    vpc_natgw_name                  = "prod-vpc01-natgw-01"
    vpc_route_table_ipv4_cidr_block = "0.0.0.0/0"
    vpc_route_table_tags = {
      Name = "private-route-table-prod"
    }
  }
}

vpc_route_table_assoc_profile = {
  public-route-table_assoc-01 = {
    subnet_name      = "public-us-east-1a"
    route_table_name = "public-route-table"
  }

  public-route-table_assoc-02 = {
    subnet_name      = "public-us-east-1b"
    route_table_name = "public-route-table"
  }

  private-route-table_assoc-01 = {
    subnet_name      = "private-us-east-1a-app"
    route_table_name = "private-route-table-01"
  }

  private-route-table_assoc-02 = {
    subnet_name      = "private-us-east-1b-app"
    route_table_name = "private-route-table-02"
  }

  private-route-table_assoc-03 = {
    subnet_name      = "private-us-east-1a-data"
    route_table_name = "private-route-table-03"
  }

  private-route-table_assoc-04 = {
    subnet_name      = "private-us-east-1b-data"
    route_table_name = "private-route-table-04"
  }
}


vpc_sg_profile = {
  prod-ecs-alb-vpc-sg = {
    vpc_name    = "prod-vpc01"
    vpc_sg_name = "prod_eshop_ecs_alb_sg"
    description = "Allow HTTP & HTTPS"
    ingress_rules = {
      allow_http_from_anywhere = {
        description      = "Allow HTTP"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
      }
      allow_https_from_anywhere = {
        description      = "Allow HTTPS"
        from_port        = 443
        to_port          = 443
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
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
    tags = {
      Name = "prod-ecs-alb-sg"
    }
  }
}

vpc_sg_ecs_task_profile = {
  prod-ecs-task-vpc-sg = {
    alb_sg_name = "prod-ecs-alb-vpc-sg"
    vpc_name    = "prod-vpc01"
    vpc_sg_name = "prod_ecs_task_sg"
    description = "Allow HTTP From ALB SG"
    tags = {
      Name = "prod-ecs-task-sg"
    }
  }
}

vpc_bastion_host_sg_profile = {
  prod-bastion-vpc-sg = {
    vpc_name    = "prod-vpc01"
    subnets     = ["private-us-east-1a-data", "private-us-east-1b-data", "private-us-east-1a-app", "private-us-east-1b-app"]
    vpc_sg_name = "prod-bastion-host-sg"
    description = "Control bastion inbound and outbound access"
    tags = {
      Name = "prod-bastion-host-sg"
    }
  }
}

vpc_rds_instance_sg_profile = {
  prod-rds-instance-sg = {
    vpc_name        = "prod-vpc01"
    security_groups = ["prod-bastion-vpc-sg", "prod-ecs-task-vpc-sg"]
    vpc_sg_name     = "prod-rds-instance-sg"
    description     = "Allow access to the RDS database instance"
    tags = {
      Name = "prod-rds-sg"
    }
  }
}

vpc_efs_sg_profile = {
  prod-efs-sg = {
    vpc_name        = "prod-vpc01"
    vpc_sg_name     = "prod-efs-sg"
    subnets         = ["private-us-east-1a-app", "private-us-east-1b-app"]
    security_groups = ["prod-bastion-vpc-sg", "prod-ecs-task-vpc-sg"]
    description     = "Allow access to the EFS File System"
    tags = {
      Name = "prod-efs-sg"
    }
  }
}


ecs_cluster_profile = {
  prod-ecs-cluster-01 = {
    ecs_fargate_cluster_name = "prod_eshop_ecs_fargate_cluster"
    tags = {
      Name = "prod-ecs-fargate-cluster"
    }
  }
}

# efs_profile = {
#   prod-nfs-efs-storage = {
#     efs_name                = "prod_ecs_efs_storage"
#     vpc_name                = "prod-vpc01"
#     subnets                 = ["private-us-east-1a-app", "private-us-east-1b-app"]
#     ecs_task_security_group = "prod-ecs-task-vpc-sg"
#     port                    = 2049
#   }
# }

efs_file_system_profile = {
  prod-efs-file-system = {
    efs_storage_name = "prod_ecs_efs_storage"
    performance_mode = "generalPurpose"
    throughput_mode  = "bursting"
    encrypted        = true
    tags = {
      Name = "prod-efs-file-system"
    }
  }
}

efs_mount_target_profile = {
  prod-efs-mount-target-1-app = {
    efs_name        = "prod-efs-file-system"
    subnet_name     = "private-us-east-1a-app"
    security_groups = ["prod-efs-sg"]
  }
  prod-efs-mount-target-2-app = {
    efs_name        = "prod-efs-file-system"
    subnet_name     = "private-us-east-1b-app"
    security_groups = ["prod-efs-sg"]
  }
}

efs_access_point_profile = {
  prod-ecs-efs-access-point-img = {
    efs_name              = "prod-efs-file-system"
    root_path             = "/eshop/prod/img/"
    owner_gid             = 1000
    owner_uid             = 1000
    root_path_permissions = 755
    tag = {
      Name = "prod-ecs-efs-access-point-img"
    }
  }
  prod-ecs-efs-access-point-modules = {
    efs_name              = "prod-efs-file-system"
    root_path             = "/eshop/prod/modules/"
    owner_gid             = 1000
    owner_uid             = 1000
    root_path_permissions = 755
    tag = {
      Name = "prod-ecs-efs-access-point-modules"
    }
  }
  prod-ecs-efs-access-point-var = {
    efs_name              = "prod-efs-file-system"
    root_path             = "/eshop/prod/var/"
    owner_gid             = 1000
    owner_uid             = 1000
    root_path_permissions = 755
    tag = {
      Name = "prod-ecs-efs-access-point-var"
    }
  }
  prod-ecs-efs-access-point-themes = {
    efs_name              = "prod-efs-file-system"
    root_path             = "/eshop/prod/themes/"
    owner_gid             = 1000
    owner_uid             = 1000
    root_path_permissions = 755
    tag = {
      Name = "prod-ecs-efs-access-point-themes"
    }
  }
  prod-ecs-efs-access-point-config = {
    efs_name              = "prod-efs-file-system"
    root_path             = "/eshop/prod/config/"
    owner_gid             = 1000
    owner_uid             = 1000
    root_path_permissions = 755
    tag = {
      Name = "prod-ecs-efs-access-point-config"
    }
  }
  prod-ecs-efs-access-point-override = {
    efs_name              = "prod-efs-file-system"
    root_path             = "/eshop/prod/override/"
    owner_gid             = 1000
    owner_uid             = 1000
    root_path_permissions = 755
    tag = {
      Name = "prod-ecs-efs-access-point-override"
    }
  }
  prod-ecs-efs-access-point-download = {
    efs_name              = "prod-efs-file-system"
    root_path             = "/eshop/prod/download/"
    owner_gid             = 1000
    owner_uid             = 1000
    root_path_permissions = 755
    tag = {
      Name = "prod-ecs-efs-access-point-download"
    }
  }
  prod-ecs-efs-access-point-upload = {
    efs_name              = "prod-efs-file-system"
    root_path             = "/eshop/prod/upload/"
    owner_gid             = 1000
    owner_uid             = 1000
    root_path_permissions = 755
    tag = {
      Name = "prod-ecs-efs-access-point-upload"
    }
  }
}

ecs_service_cloudwatch_log_group_profile = {
  prod-ecs-svc-cloudwatch-log-group = {
    cw_log_group_name = "prod-ecs-svc-log-group"
    retention_in_days = 30
    tags = {
      Name = "prod-ecs-svc-log-group"
    }
  }
}

ecs_task_definition_profile = {
  prod-ecs-task-definition = {
    ecs_task_definition_family                   = "prod_eshop_ecs_task"
    ecs_task_definition_requires_compatibilities = ["FARGATE"]
    ecs_task_definition_network_mode             = "awsvpc"
    ecs_task_definition_memory                   = 4096
    ecs_task_definition_cpu                      = 2048
    # ecs_task_definition_volume_name              = "prod_efs"
    efs_name              = "prod-efs-file-system"
    db_instance_name      = "prod-ecs-db-instance"
    log_group_name        = "prod-ecs-svc-cloudwatch-log-group"
    access_point_img      = "prod-ecs-efs-access-point-img"
    access_point_modules  = "prod-ecs-efs-access-point-modules"
    access_point_themes   = "prod-ecs-efs-access-point-themes"
    access_point_var      = "prod-ecs-efs-access-point-var"
    access_point_config   = "prod-ecs-efs-access-point-config"
    access_point_override = "prod-ecs-efs-access-point-override"
    access_point_download = "prod-ecs-efs-access-point-download"
    access_point_upload   = "prod-ecs-efs-access-point-upload"
    tags = {
      Name = "prod-ecs-task-definition"
    }
  }
}

ecs_alb_profile = {
  prod-ecs-alb = {
    alb_sg_name                = "prod-ecs-alb-vpc-sg"
    subnets                    = ["public-us-east-1a", "public-us-east-1b"]
    load_balancer_name         = "prod-eshop-ecs-alb"
    internal                   = false
    load_balancer_type         = "application"
    enable_deletion_protection = false
    tags = {
      Name = "prod-ecs-alb"
    }
  }
}

ecs_alb_target_group_profile = {
  prod-ecs-alb-target-group = {
    vpc_name = "prod-vpc01"

    alb_target_group_name = "prod-ecs-alb-target-group"
    port                  = 80
    protocol              = "HTTP"
    target_type           = "ip"
    health_check_points = {
      health_check = {
        healthy_threshold   = "3"
        interval            = "120"
        protocol            = "HTTP"
        matcher             = "200"
        path                = "/index.php"
        timeout             = "3"
        unhealthy_threshold = "2"
      }
    }
    tags = {
      Name = "prod-ecs-alb-target-group"
    }
  }
}

ecs_alb_listener_profile = {
  prod-ecs-alb-listener = {
    alb_name              = "prod-ecs-alb"
    alb_target_group_name = "prod-ecs-alb-target-group"
    acm_cert_name         = "prod-acm-certificate"
    port                  = 80
    protocol              = "HTTP"
    type                  = "forward"
    tags = {
      Name = "prod-ecs-alb-listener"
    }
  }
}

ecs_service_profile = {
  prod-ecs-service = {
    ecs_cluster_name         = "prod-ecs-cluster-01"
    ecs_task_definition_name = "prod-ecs-task-definition"
    ecs_task_security_group  = "prod-ecs-task-vpc-sg"
    subnets                  = ["private-us-east-1a-app", "private-us-east-1b-app"]
    target_group_name        = "prod-ecs-alb-target-group"

    ecs_service_name                   = "prod_eshop_ecs_service"
    desired_count                      = 2
    deployment_minimum_healthy_percent = 75
    deployment_maximum_percent         = 200
    launch_type                        = "FARGATE"
    scheduling_strategy                = "REPLICA"
    assign_public_ip                   = false
    container_name                     = "eshop"
    container_port                     = 80
    tags = {
      Name = "prod-ecs-service"
    }
  }
}

ecs_appautoscaling_target_profile = {
  prod-ecs-appautoscaling-target = {
    app_autoscale_max_capacity       = 10
    app_autoscale_min_capacity       = 2
    ecs_cluster_name                 = "prod-ecs-cluster-01"
    ecs_service_name                 = "prod-ecs-service"
    app_autoscale_scalable_dimension = "ecs:service:DesiredCount"
    app_autoscale_service_namespace  = "ecs"
  }
}

ec2_instance_profile = {
  prod-ec2-bastion-host = {
    instance_type = "t2.micro"
    user_data     = <<EOF
#!/bin/bash
sudo yum update -y
yum install -y mysql
EOF
    key_name      = "prod-ec2-bastion-host-key-pair"
    subnet_name   = "public-us-east-1a"
    vpc_sg_name   = "prod-bastion-vpc-sg"
    tags = {
      Name = "prod-ec2-bastion-host"
    }
  }
}

db_subnet_group_profile = {
  prod-ecs-db-subnet-group = {
    db_subnet_group_name = "prod-ecs-db-subnet-group"
    subnets              = ["private-us-east-1a-data", "private-us-east-1b-data"]
    tags = {
      Name = "prod-ecs-db-subnet-group"
    }
  }
}

db_instance_profile = {
  prod-ecs-db-instance = {
    db_subnet_group_name       = "prod-ecs-db-subnet-group"
    security_groups            = ["prod-rds-instance-sg"]
    db_instance_identifier     = "prod-eshop-db-instance"
    db_name                    = "prod-eshop-db"
    allocated_storage          = 20
    db_storage_type            = "gp2"
    db_engine                  = "mysql"
    db_engine_version          = "5.7"
    db_instance_class          = "db.t4g.medium"
    db_password                = "P4ssw0rd"
    db_username                = "eshopdb-user"
    db_backup_retention_period = 15
    db_multi_az                = true
    db_skip_final_snapshot     = false
    tags = {
      Name = "prod-db-instance"
    }
  }
}

acm_certificate_profile = {
  prod-acm-certificate = {
    domain_name               = "eshop.com"
    subject_alternative_names = ["*.eshop.com"]
    validation_method         = "DNS"
    tags = {
      Name = "prod-acm-cert"
    }
  }
}