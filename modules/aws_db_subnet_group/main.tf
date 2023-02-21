resource "aws_db_subnet_group" "prod_db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids

  tags = var.prod_db_subnet_group_tags
}