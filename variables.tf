variable "region" {
  description = "Região da AWS"
  type        = string
  default     = "us-east-1"
}

variable "private_subnets" {
  description = "Subnets privadas usadas pelo VPC Link"
  type        = list(string)
  default     = []
}

variable "alb_sg_id" {
  description = "Security Group usado pelo VPC Link"
  type        = string
  default     = ""
}

variable "alb_listener_arn" {
  description = "ARN do Listener do ALB para a integração HTTP_PROXY"
  type        = string
  default     = ""
}
