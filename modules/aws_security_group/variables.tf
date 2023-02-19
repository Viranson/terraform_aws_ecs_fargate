variable "vpc_sg_name" {
  type        = string
  description = "Name of the Security Group"
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
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "Security Group description"
  default = {
    ingress = {
      description      = "Allow HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
}