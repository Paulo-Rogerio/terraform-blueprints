
# ------------------------------------------------------------------------------
# VPC
# ------------------------------------------------------------------------------

module "vpc" {
  source = "git::https://github.com/Paulo-Rogerio/terraform-modules.git//cloudstack/vpc?ref=v0.0.5"

  name                     = var.name
  cidr                     = var.cidr
  zone                     = var.zone
  vpc_offering             = var.vpc_offering
  subnets                  = var.subnets
  default_network_offering = var.default_network_offering
  subnet_names             = var.subnet_names

  #tags = merge(
  #  {
  #    "Name" = format("%s", var.name)
  #  },
  #  var.tags
  #)

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

}

