variable "efs_storage_name" {
  type        = string
  description = "Unique name used as reference when creating the EFS to ensure idempotent file system creation"
}

variable "efs_storage_tags" {
  type        = map(any)
  description = "Tags to assign to the file system"
}

variable "performance_mode" {
  description = "The file system performance mode"
  type        = string
  default     = "generalPurpose"
}
variable "throughput_mode" {
  description = "Throughput mode for the file system"
  type        = string
  default     = "bursting"
}

variable "provisioned_throughput_in_mibps" {
  description = "The throughput, measured in MiB/s, that you want to provision for the file system. Only applicable with throughput_mode set to provisioned"
  type        = string
  default     = null
}

variable "encrypted" {
  description = "If true, the disk will be encrypted"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. When specifying kms_key_id, encrypted needs to be set to true"
  type        = string
  default     = null
}

variable "lifecycle_policy" {
  description = "A file system lifecycle policy object with optional transition_to_ia and transition_to_primary_storage_class"
  type        = map(string)
  default     = {}

  validation {
    condition = length(setsubtract(keys(var.lifecycle_policy), [
      "transition_to_ia", "transition_to_primary_storage_class"
      ])) == 0 && length(distinct(concat([
        "AFTER_7_DAYS", "AFTER_14_DAYS", "AFTER_30_DAYS", "AFTER_60_DAYS", "AFTER_90_DAYS"
        ], compact([lookup(var.lifecycle_policy, "transition_to_ia", null)])))) == 5 && length(distinct(concat([
        "AFTER_1_ACCESS"
    ], compact([lookup(var.lifecycle_policy, "transition_to_primary_storage_class", null)])))) == 1
    error_message = "Lifecycle Policy variable map contains invalid key-value arguments."
  }
}