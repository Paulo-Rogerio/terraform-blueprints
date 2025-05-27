
# ------------------------------------------------------------------------------
# VPC
# ------------------------------------------------------------------------------

module "vpc" {
  #source = "git::https://github.com/Paulo-Rogerio/terraform-modules.git//cloudstack/vpc?ref=v0.0.6s"

  source                   = "../../../terraform-modules/cloudstack/vpc"

  name                     = var.name
  cidr                     = var.cidr
  zone                     = var.zone
  vpc_offering             = var.vpc_offering
  #subnets                  = var.subnets
  #default_network_offering = var.default_network_offering
  #ssubnet_names             = var.subnet_names

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

