variable "alb_target_group_name" {
  type        = string
  description = "Name of the target group"
}

variable "port" {
  type        = number
  description = "Port on which targets receive traffic"
}

variable "protocol" {
  type        = string
  description = "Protocol to use for routing traffic to the targets"
  # default     = "HTTP"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC in which to create the target group"
}

variable "target_type" {
  type        = string
  description = "Type of target that must be specified when registering targets with this target group"
  # default     = "ip"
}

variable "health_check_points" {
  description = "Health Check configuration block"
  # default = {
  #   health_check = {
  #     healthy_threshold   = "3"
  #     interval            = "30"
  #     protocol            = "HTTP"
  #     matcher             = "200"
  #     timeout             = "3"
  #     unhealthy_threshold = "2"
  #   }
  # }
}

variable "alb_taget_group_tags" {
  type        = map(any)
  description = "ALB Target Group Resource Tags"
}