# main.tf
provider "aws" {
  region = var.region
}

resource "aws_apigatewayv2_vpc_link" "vpc_link" {
  name               = "fastfood-vpc-link"
  security_group_ids = [var.lb_security_group_id]
  subnet_ids         = var.private_subnets
}

resource "aws_apigatewayv2_api" "http_api" {
  name          = "fastfood-http-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "alb_integration" {
  api_id           = aws_apigatewayv2_api.http_api.id
  integration_type = "HTTP_PROXY"
  integration_uri  = var.alb_listener_arn
  integration_method = "ANY"
  connection_type  = "VPC_LINK"
  connection_id    = aws_apigatewayv2_vpc_link.vpc_link.id
  payload_format_version = "1.0"
}

resource "aws_apigatewayv2_route" "proxy_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.alb_integration.id}"
}

resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
}

output "http_api_endpoint" {
  value = aws_apigatewayv2_api.http_api.api_endpoint
}