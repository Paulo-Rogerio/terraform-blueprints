# ------------------------------------------------------------------------------
# ENVIRONMENT
# ------------------------------------------------------------------------------

variable "environment" {
  description = "The environment name"
  type        = string
}

variable "aws_region" {
  description = "AWS region in which resources will be provisioned"
  type        = string
}

variable "tags" {
  description = "Key-value mapping of resource tags"
  type        = map(string)
}

# ------------------------------------------------------------------------------
# VPC
# ------------------------------------------------------------------------------

variable "cidr" {
  description = "The CIDR block of the VPC. It **must** use the `10.XXX.0.0/16` format"
  type        = string

  validation {
    condition     = can(regex("^10\\.[0-9]+\\.0\\.0/16$", var.cidr))
    error_message = "The VPC CIDR must use the '10.XXX.0.0/16' format."
  }
}

variable "key_pair_pubkey" {
  description = "The public key contents to create the VPC key pair"
  type        = string
}

variable "single_nat_gateway" {
  description = "Enable to provision a single shared NAT Gateway across all of the private networks"
  type        = bool
  default     = false
}

variable "one_nat_gateway_per_az" {
  description = "Enable to provision only one NAT Gateway per availability zone"
  type        = bool
  default     = true
}

variable "allow_cidr_blocks" {
  description = "A list of CIDR blocks to be allowed on the VPC default security group"
  # Example:
  #
  # [
  #   {
  #     description = "Account foo's VPC"
  #     cidr_block  = "10.10.0.0/16"
  #     from_port   = 0     # Optional
  #     to_port     = 0     # Optional
  #     protocol    = "-1"  # Optional
  #   },
  # ]
  #
  # NOTE: Terraform doesn't allow optional object() attributes, so we must use map(string) for now.
  # See https://github.com/hashicorp/terraform/issues/19898
  type    = list(map(string))
  default = []
}

variable "enable_dns_hostnames" {
  description = "Enable private DNS resolutions in the VPC. Required when using Route 53 private hosted zones in the account"
  type        = bool
  default     = false
}

variable "enable_vpn_gateway" {
  description = "Whether to create a new VPN Gateway resource and attach it to the VPC"
  type        = bool
  default     = false
}

variable "propagate_private_route_tables_vgw" {
  description = "Whether to propagate VPN gateway routes to the private route tables"
  type        = bool
  default     = true
}

variable "propagate_public_route_tables_vgw" {
  description = "Whether to propagate VPN gateway routes to the public route tables"
  type        = bool
  default     = true
}

variable "enabled_vpc_endpoints" {
  description = "List of VPC endpoints to be used within the VPC"
  type = list(object(
    {
      name                = string
      service             = optional(string)
      service_name        = optional(string)
      service_type        = string
      policy              = optional(string)
      private_dns_enabled = optional(string)
    }
  ))
  default = [
    {
      name         = "s3"
      service      = "s3"
      service_type = "Gateway"
    },
    {
      name         = "dynamodb"
      service      = "dynamodb"
      service_type = "Gateway"
    },
  ]
}
