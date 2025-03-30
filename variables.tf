variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "public_subnets" {
  description = "Public subnets used by VPC Link"
  type        = list(string)
  default     = []
}

variable "vpc_link_sg_id" {
  description = "Security Group ID used by VPC Link"
  type        = string
  default     = ""
}

variable "alb_listener_arn" {
  description = "ARN do listener do ALB usado na integração"
  type        = string
  default     = ""
}