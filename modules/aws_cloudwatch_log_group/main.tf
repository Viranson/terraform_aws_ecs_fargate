resource "aws_cloudwatch_log_group" "prod_cw_log_group" {
  name = var.cw_log_group_name
  tags = var.cw_log_group_tags
}