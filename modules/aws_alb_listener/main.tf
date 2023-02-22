resource "aws_alb_listener" "prod_alb_listener" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol
  certificate_arn   = var.certificate_arn

  default_action {
    type = var.type
    # type = "redirect"

    # redirect {
    #   port        = "443"
    #   protocol    = "HTTPS"
    #   status_code = "HTTP_301"
    # }
    target_group_arn = var.target_group_arn
  }

  tags = var.alb_listener_tags
}