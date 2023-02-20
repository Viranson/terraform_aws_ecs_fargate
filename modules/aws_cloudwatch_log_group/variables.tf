variable "cw_log_group_name" {
  type        = string
  description = "The name of the log group"
}

variable "cw_log_group_tags" {
  type        = map(any)
  description = "Tags to assign to the resource"
}