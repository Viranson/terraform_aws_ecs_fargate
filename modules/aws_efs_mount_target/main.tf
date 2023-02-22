resource "aws_efs_mount_target" "prod_efs_storage_mount_target" {
  # count = length(var.subnet_ids)

  file_system_id  = var.file_system_id
  subnet_id       = var.subnet_id
  security_groups = var.vpc_sg_ids
}