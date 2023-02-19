resource "aws_alb_listener" "prod_alb_listener" {
  load_balancer_arn = var.load_balancer_id
  port              = var.port
  protocol          = var.protocol

  default_action {
    target_group_arn = var.target_group_arn
    type             = var.type
  }

  tags = var.alb_listener_tags
}