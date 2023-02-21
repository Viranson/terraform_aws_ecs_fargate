resource "aws_db_instance" "prod_db_instance" {
  identifier              = var.db_instance_identifier
  db_name                 = var.db_name
  allocated_storage       = var.allocated_storage
  storage_type            = var.db_storage_type
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  db_subnet_group_name    = var.db_subnet_group_name
  password                = var.db_password
  username                = var.db_username
  backup_retention_period = var.db_backup_retention_period #0
  multi_az                = var.db_multi_az                #false
  skip_final_snapshot     = var.db_skip_final_snapshot     #true
  vpc_security_group_ids  = var.db_vpc_security_group_ids

  tags = var.prod_db_instance_tags
}