variable "ec2_ami" {
  type        = string
  description = "AMI to use for the instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type to use for the instance"
}

variable "user_data" {
  type        = string
  description = "User data to provide when launching the instance"
}

variable "iam_instance_profile_name" {
  type        = string
  description = "IAM Instance Profile to launch the instance with"
}

variable "key_name" {
  type        = string
  description = "Key name of the Key Pair to use for the instance"
}

variable "subnet_id" {
  type        = string
  description = "VPC Subnet ID to launch in"
}

variable "security_group_ids" {
  type        = list(any)
  description = "List of security group names to associate with"
}

variable "prod_ec2_instance_tags" {
  type        = map(any)
  description = "Tags to assign to EC2 Instance Ressource"
}