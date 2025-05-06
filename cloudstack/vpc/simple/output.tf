# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# Source NAT IP
output "vpc_source_nat_ip" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_source_nat_ip
}

# Display text
output "vpc_display_text" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_display_text
}

output "vpc_network_ids" {
  description = "The IDs of the network/tier in the VPC"
  value       = module.vpc.network_id
}