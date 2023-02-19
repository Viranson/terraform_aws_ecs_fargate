variable "load_balancer_name" {
  type        = string
  description = "The unique name of the LB"
}

variable "internal" {
  type        = bool
  description = "Set if the LB is internal or not"
  # default     = false
}

variable "load_balancer_type" {
  type        = string
  description = "The type of load balancer to create"
  # default     = "application"
}

variable "security_groups" {
  type        = list(any)
  description = "List of security group IDs to assign to the LB. Only valid for Application Load Balancers"
}

variable "subnets" {
  type        = list(any)
  description = "List of subnet IDs to attach to the LB"
}

variable "enable_deletion_protection" {
  type        = bool
  description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer."
  # default     = true
}

variable "lb_tags" {
  type        = map(any)
  description = "LB Resource Tags"
}