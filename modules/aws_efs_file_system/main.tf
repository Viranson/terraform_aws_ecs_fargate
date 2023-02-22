resource "aws_efs_file_system" "prod_efs_storage" {
  creation_token = "${var.efs_storage_name}-efs"

  performance_mode                = var.performance_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps
  throughput_mode                 = var.throughput_mode

  encrypted  = var.encrypted
  kms_key_id = var.kms_key_id

  dynamic "lifecycle_policy" {
    for_each = var.lifecycle_policy
    content {
      transition_to_ia                    = lifecycle_policy.key == "transition_to_ia" ? lifecycle_policy.value : null
      transition_to_primary_storage_class = lifecycle_policy.key == "transition_to_primary_storage_class" ? lifecycle_policy.value : null
    }
  }

  tags = var.prod_efs_storage_tags
}