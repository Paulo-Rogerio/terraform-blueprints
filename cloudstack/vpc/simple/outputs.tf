# ------------------------------------------------------------------------------
# VPC
# ------------------------------------------------------------------------------

output "vpc_id" {
  description = "The VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_name" {
  description = "The VPC name"
  value       = module.vpc.name
}

output "vpc_cidr_block" {
  description = "The VPC CIDR block"
  value       = module.vpc.vpc_cidr_block
}

output "azs" {
  description = "The list of eligible AZs for provisioning the VPC subnets"
  value       = module.vpc.azs
}

