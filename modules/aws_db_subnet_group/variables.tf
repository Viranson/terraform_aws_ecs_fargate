variable "db_subnet_group_name" {
  type        = string
  description = "The name of the DB subnet group"
}

variable "subnet_ids" {
  type        = list(any)
  description = "List of VPC subnet IDs"
}

variable "prod_db_subnet_group_tags" {
  type        = map(any)
  description = "Tags to assigne to the resource"
}