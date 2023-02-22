resource "aws_efs_access_point" "permissions" {
  #   count = var.create_efs_ap ? 1 : 0

  file_system_id = var.file_system_id
  posix_user {
    gid = 1000
    uid = 1000
  }
  root_directory {
    path = var.root_path
    creation_info {
      owner_gid   = var.owner_gid
      owner_uid   = var.owner_uid
      permissions = var.root_path_permissions
    }
  }

  tags = var.efs_access_point_tags
}