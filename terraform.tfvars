region     = "us-east-1"
access_key = ""
secret_key = ""

# = "prod_eshop

vpc_profile = {
  prod-vpc01 = {
    vpc_ipv4_cidr_block = "10.200.0.0/16"
    vpc_tags = {
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
  }
}

vpc_sg_ecs_task_profile = {
  prod-ecs-task-vpc-sg = {
    alb_sg_name = "prod-ecs-alb-vpc-sg"
    vpc_name    = "prod-vpc01"
    vpc_sg_name = "prod_ecs_task_sg"
    description = "Allow HTTP From ALB SG"
  }
}


ecs_cluster_profile = {
  prod-ecs-cluster-01 = {
    ecs_fargate_cluster_name = "prod_eshop_ecs_fargate_cluster"
  }
}

efs = {
  prod-nfs-efs-storage = {
    efs_name                    = "prod_ecs_efs_storage"
    vpc_name                = "prod-vpc01"
    subnets                 = ["private-us-east-1a-app", "private-us-east-1b-app"]
    ecs_task_security_group = "prod-ecs-task-vpc-sg"
    port                    = 2049
  }
}

ecs_task_definition_profile = {
  prod-ecs-task-definition = {
    ecs_task_definition_family                   = "prod_eshop_ecs_task"
    ecs_task_definition_requires_compatibilities = ["FARGATE"]
    ecs_task_definition_network_mode             = "awsvpc"
    ecs_task_definition_memory                   = 4096
    ecs_task_definition_cpu                      = 2048
    ecs_task_definition_volume_name              = "prod_efs"
    efs_name                                     = "prod-nfs-efs-storage"
    transit_encryption                           = "DISABLED"
    root_directory                               = "/prod/"
    iam_auth                                     = "DISABLED"
  }
}

ecs_alb_profile = {
  prod-ecs-alb = {
    alb_sg_name                = "prod-ecs-alb-vpc-sg"
    subnets                    = ["public-us-east-1a", "public-us-east-1b"]
    load_balancer_name         = "prod-eshop-ecs-alb"
    internal                   = false
    load_balancer_type         = "application"
    enable_deletion_protection = true
  }
}

ecs_alb_target_group = {
  prod-ecs-alb-target-group = {
    vpc_name = "prod-vpc01"

    alb_target_group_name = "prod-ecs-alb-target-group"
    port                  = 80
    protocol              = "HTTP"
    target_type           = "ip"
    health_check_points = {
      health_check = {
        healthy_threshold   = "3"
        interval            = "30"
        protocol            = "HTTP"
        matcher             = "200"
        path                = "/"
        timeout             = "3"
        unhealthy_threshold = "2"
      }
    }
  }
}

ecs_alb_listener = {
  prod-ecs-alb-listener = {
    alb_name              = "prod-ecs-alb"
    alb_target_group_name = "prod-ecs-alb-target-group"

    port     = 80
    protocol = "HTTP"
    type     = "forward"
  }
}

ecs_service = {
  prod-ecs-service = {
    ecs_cluster_name         = "prod-ecs-cluster-01"
    ecs_task_definition_name = "prod-ecs-task-definition"
    ecs_task_security_group  = "prod-ecs-task-vpc-sg"
    subnets                  = ["private-us-east-1a-app", "private-us-east-1b-app"]
    target_group_name        = "prod-ecs-alb-target-group"

    ecs_service_name                   = "prod_eshop_ecs_service"
    desired_count                      = 4
    deployment_minimum_healthy_percent = 75
    deployment_maximum_percent         = 200
    launch_type                        = "FARGATE"
    scheduling_strategy                = "REPLICA"
    assign_public_ip                   = false
    container_name                     = "eshop"
    container_port                     = 80
  }
}