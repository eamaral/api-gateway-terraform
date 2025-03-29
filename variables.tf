variable "region" {
  description = "AWS region"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets used by VPC Link"
  type        = list(string)
}

variable "vpc_link_sg_id" {
  description = "Security Group ID used by VPC Link"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the ALB used for integration"
  type        = string
}