variable "file_system_id" {
  type        = string
  description = "ID of the file system for which the mount target is intended"
}

variable "subnet_id" {
  type        = string
  description = " ID of the subnet to add the mount target in"
}

variable "vpc_sg_ids" {
  description = "List of up to 5 VPC security group IDs (that must be for the same VPC as subnet specified) in effect for the mount target"
  type        = list(string)
}