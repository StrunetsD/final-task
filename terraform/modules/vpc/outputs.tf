output "created_vpc_id" {
  description = "The ID of the VPC created by the module."
  value       = aws_vpc.main_vpc.id
}

output "created_public_subnets_ids" {
  description = "IDs of the public subnets created by the module, mapped by AZ."
  value       = { for az, s in aws_subnet.public_subnets : az => s.id } 
}

output "created_public_subnets_cidrs" {
  description = "CIDR blocks of the public subnets created by the module, mapped by AZ."
  value       = { for az, s in aws_subnet.public_subnets : az => s.cidr_block }
}

output "main_route_table_ids" {
  value       = aws_route_table.main_route_table.id 
  description = "Map of public route table IDs per AZ"
}

output "internet_gateway_id" {
  value = aws_internet_gateway.main_gateway.id
}

output "security_group_id" {
  description = "List of security group IDs created for the EC2 instance(s)."
  value       = aws_security_group.security_group.id
}