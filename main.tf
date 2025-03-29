provider "aws" {
  region = var.region
}

resource "aws_apigatewayv2_api" "fastfood_api" {
  name          = "fastfood-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.fastfood_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_vpc_link" "fastfood_vpc_link" {
  name               = "fastfood-vpc-link"
  subnet_ids         = var.public_subnets
  security_group_ids = [var.vpc_link_sg_id]
}

resource "aws_apigatewayv2_integration" "alb_integration" {
  api_id                 = aws_apigatewayv2_api.fastfood_api.id
  integration_type       = "HTTP_PROXY"
  integration_method     = "ANY"
  integration_uri        = var.alb_dns_name
  connection_type        = "VPC_LINK"
  connection_id          = aws_apigatewayv2_vpc_link.fastfood_vpc_link.id
  payload_format_version = "1.0"
}

resource "aws_apigatewayv2_route" "proxy_route" {
  api_id    = aws_apigatewayv2_api.fastfood_api.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.alb_integration.id}"
}

output "api_gateway_url" {
  value = aws_apigatewayv2_api.fastfood_api.api_endpoint
}