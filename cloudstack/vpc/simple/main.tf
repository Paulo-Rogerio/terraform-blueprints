
# ------------------------------------------------------------------------------
# VPC
# ------------------------------------------------------------------------------

module "vpc" {
  source = "git::https://github.com/Paulo-Rogerio/terraform-modules.git//cloudstack/vpc?ref=v0.0.4"

  #source = "../../../../terraform-modules/cloudstack/vpc"

  name                     = "simple-example"
  cidr                     = "10.0.0.0/16"
  zone                     = "Enterprise_Internet_Bi"
  vpc_offering             = "Default VPC offering"
  subnets                  = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  default_network_offering = "NAT for VPC"
  subnet_names             = ["nw-1", "nw-2", "nw-3"]
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

