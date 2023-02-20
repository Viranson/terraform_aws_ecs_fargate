#                                 (Total CPU units used by tasks in service) x 100
# Service CPU utilization =  ------------------------------------------------------------
#                           (Total CPU units defined in task definition) x number of task

resource "aws_appautoscaling_target" "prod_ecs_svc_autoscaling_target" {
  max_capacity       = var.app_autoscale_max_capacity
  min_capacity       = var.app_autoscale_min_capacity
  resource_id        = "service/${var.ecs_cluster_name}/${var.ecs_service_name}"
  scalable_dimension = var.app_autoscale_scalable_dimension
  service_namespace  = var.app_autoscale_service_namespace
  role_arn           = aws_iam_role.prod_ecs_autoscale_role.arn
}

resource "aws_iam_role" "prod_ecs_autoscale_role" {
  name               = "ecs-service-autoscale"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "application-autoscaling.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "prod_ecs_autoscale" {
  role       = aws_iam_role.prod_ecs_autoscale_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}

resource "aws_appautoscaling_policy" "ecs_target_cpu" {
  name               = "application-scaling-policy-cpu"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.prod_ecs_svc_autoscaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.prod_ecs_svc_autoscaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.prod_ecs_svc_autoscaling_target.service_namespace
  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 80
  }
  depends_on = [aws_appautoscaling_target.prod_ecs_svc_autoscaling_target]
}