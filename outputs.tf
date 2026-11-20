output "environment" {
  description = "Environment deployed by this Terraform configuration."
  value       = var.environment
}

output "vpc_id" {
  description = "ID of the created VPC."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = [for subnet in aws_subnet.private : subnet.id]
}

output "nat_gateway_id" {
  description = "NAT Gateway ID, or null when NAT is disabled."
  value       = var.enable_nat_gateway ? aws_nat_gateway.main[0].id : null
}
