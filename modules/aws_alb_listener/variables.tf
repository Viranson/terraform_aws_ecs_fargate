variable "load_balancer_id" {
  type        = string
  description = "ARN of the load balancer"
}

variable "port" {
  type        = string
  description = "Port on which the load balancer is listening"
}

variable "protocol" {
  type        = string
  description = "Protocol for connections from clients to the load balancer"
  # default     = "HTTP"
}

variable "target_group_arn" {
  type        = string
  description = "ARN of the Target Group to which to route traffic"
}

variable "type" {
  type        = string
  description = "Type of routing action"
  # default     = "forward"
}

variable "alb_listener_tags" {
  type        = map(any)
  description = "ALB Listener Resource Tags"
}