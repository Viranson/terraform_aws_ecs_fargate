variable "file_system_id" {
  type = string
}

variable "root_path" {
  type = string
}

# # Rules
# variable "create_efs_ap" {
#   description = "Create custom permissions to root of EFS"
#   type        = bool
#   default     = false
# }

# Add permissions to root directory EFS
variable "root_path_permissions" {
  type    = string
  default = "0777"
}
variable "owner_gid" {
  description = "Specifies the POSIX group ID to apply to the root_directory"
  type        = number
  default     = 0
}
variable "owner_uid" {
  description = "Specifies the POSIX user ID to apply to the root_directory"
  type        = number
  default     = 0
}