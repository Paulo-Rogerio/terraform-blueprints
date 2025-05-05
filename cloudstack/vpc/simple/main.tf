# ------------------------------------------------------------------------------
# LOCALS
# ------------------------------------------------------------------------------

locals {
  vpc_name = var.environment

  # CIDRs dedicated to EC2/non-Kubernetes workloads
  ec2_public_subnet_cidrs = [
    cidrsubnet(var.cidr, 5, 0), # e.g. 10.0.0.0/21
    cidrsubnet(var.cidr, 5, 1), # e.g. 10.0.8.0/21
    cidrsubnet(var.cidr, 5, 2), # 
    cidrsubnet(var.cidr, 5, 3),
    cidrsubnet(var.cidr, 5, 4),
  ]

  ec2_private_subnet_cidrs = [
    cidrsubnet(var.cidr, 5, 5), 
    cidrsubnet(var.cidr, 5, 6),
    cidrsubnet(var.cidr, 5, 7),
    cidrsubnet(var.cidr, 5, 8),
    cidrsubnet(var.cidr, 5, 9),
  ]


  number_of_azs_per_region = {
    us-east-1 = 5
    us-east-2 = 3
    sa-east-1 = 3
  }

  number_of_azs = local.number_of_azs_per_region[var.aws_region]

  public_subnets       = slice(local.ec2_public_subnet_cidrs, 0, local.number_of_azs)
  private_subnets      = slice(local.ec2_private_subnet_cidrs, 0, local.number_of_azs)

  extra_security_group_ingress = [
    for spec in var.allow_cidr_blocks :
    {
      from_port   = lookup(spec, "from_port", 0)
      to_port     = lookup(spec, "to_port", 0)
      protocol    = lookup(spec, "protocol", -1)
      cidr_blocks = spec.cidr_block
      description = spec.description
    }
  ]
}

# ------------------------------------------------------------------------------
# TAGS
# ------------------------------------------------------------------------------
module "tags" {
  source = "git::https://github.com/Paulo-Rogerio/terraform-aws-modules?ref=main/tree/main/tags"

  environment = var.environment

  tags = var.tags
}

# ------------------------------------------------------------------------------
# DATA SOURCES
# ------------------------------------------------------------------------------

data "aws_availability_zones" "available" {
  state = "available"

  exclude_names = [
    "us-east-1e",
  ]
}

# ------------------------------------------------------------------------------
# VPC
# ------------------------------------------------------------------------------

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.4.0"

  name = local.vpc_name

  cidr = var.cidr
  azs  = data.aws_availability_zones.available.names

  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets

  private_subnet_suffix = "ec2-private"
  public_subnet_suffix  = "ec2-public"

  private_subnet_tags = {
    SubnetTier = "Private"
  }

  public_subnet_tags = {
    SubnetTier = "Public"
  }

  # NAT Gateway
  # See https://github.com/terraform-aws-modules/terraform-aws-vpc#nat-gateway-scenarios
  enable_nat_gateway     = true
  one_nat_gateway_per_az = var.one_nat_gateway_per_az
  single_nat_gateway     = var.single_nat_gateway

  # DNS settings
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = true

  # VPN Gateway
  enable_vpn_gateway                 = var.enable_vpn_gateway
  propagate_private_route_tables_vgw = var.propagate_private_route_tables_vgw
  propagate_public_route_tables_vgw  = var.propagate_public_route_tables_vgw

  # Default security group
  manage_default_security_group = true

  default_security_group_ingress = concat(
    [
      {
        from_port   = 0
        to_port     = 0
        protocol    = -1
        self        = true
        description = "Default security group"
      },
      {
        from_port   = 0
        to_port     = 0
        protocol    = -1
        cidr_blocks = var.cidr
        description = "VPC CIDR"
      },
    ],
    local.extra_security_group_ingress,
  )

  default_security_group_egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all"
    },
  ]

}

