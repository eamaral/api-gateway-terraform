variable "region" {
  default = "us-east-1"
}

variable "private_subnets" {
  description = "Lista de subnets privadas"
  type        = list(string)
}

variable "lb_security_group_id" {
  description = "Security Group do Load Balancer"
  type        = string
}

variable "alb_listener_arn" {
  description = "ARN do listener do ALB interno"
  type        = string
}