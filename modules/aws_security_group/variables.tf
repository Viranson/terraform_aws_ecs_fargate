variable "vpc_sg_name" {
  type        = string
  description = "Name of the Security Group"
}

variable "description" {
  type        = string
  description = "Security group description"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC attached to the Security Group"
}

variable "vpc_sg_tags" {
  type        = map(any)
  description = "Security Group Tags"
}

variable "ingress_rules" {
  description = "Security Group ingress rules description"
}

variable "egress_rules" {
  description = "Security Group egress rules description"
}