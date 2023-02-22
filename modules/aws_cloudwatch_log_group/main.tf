resource "aws_cloudwatch_log_group" "prod_cw_log_group" {
  name              = var.cw_log_group_name
  retention_in_days = var.retention_in_days
  tags              = var.cw_log_group_tags
}