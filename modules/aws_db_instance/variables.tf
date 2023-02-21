variable "prod_db_instance_tags" {
  type        = map(any)
  description = "Tags to assign to the resource"
}

variable "db_instance_identifier" {
  type        = string
  description = "The name of the RDS instance"
}

variable "db_name" {
  type        = string
  description = "Name of the database to create when the DB instance is created"
}

variable "allocated_storage" {
  type        = number
  description = "Allocated storage in gibibytes"
}

variable "db_storage_type" {
  type        = string
  description = "Type of storage to use to provision db instance"
}

variable "db_engine" {
  type        = string
  description = "The database engine to use"
}

variable "db_engine_version" {
  type        = string
  description = "The engine version to use"
}

variable "db_instance_class" {
  type        = string
  description = "The instance type of the RDS instance"
}

variable "db_subnet_group_name" {
  type        = string
  description = "Name of DB subnet group"
}

variable "db_password" {
  type        = string
  description = "Password for the master DB user"
  sensitive   = true
}

variable "db_username" {
  type        = string
  description = "Username of the Master DB user"
}

variable "db_backup_retention_period" {
  type        = number
  description = "The days to retain backups for"
}

variable "db_multi_az" {
  type        = bool
  description = "Specifies if the RDS instance is multi-AZ"
}

variable "db_skip_final_snapshot" {
  type        = bool
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
}

variable "db_vpc_security_group_ids" {
  type        = list(any)
  description = "List of VPC security groups to associate"
}

variable "prod_db_instance_tags" {
  type        = map(any)
  description = "Tags to assign to the resource"
}