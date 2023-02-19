resource "aws_lb" "prod_alb" {
  name                       = var.load_balancer_name
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  security_groups            = var.security_groups            # [aws_security_group.alb_sg.id]
  subnets                    = var.subnets                    #data.terraform_remote_state.vpc.outputs.public_subnets
  enable_deletion_protection = var.enable_deletion_protection #false
  tags                       = var.lb_tags
}