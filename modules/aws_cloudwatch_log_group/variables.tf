variable "cw_log_group_name" {
  type        = string
  description = "The name of the log group"
}

variable "retention_in_days" {
  type        = number
  description = "Specifies the number of days to retain log events in the specified log group"
}

variable "cw_log_group_tags" {
  type        = map(any)
  description = "Tags to assign to the resource"
}