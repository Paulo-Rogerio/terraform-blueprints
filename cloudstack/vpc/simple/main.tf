
# ------------------------------------------------------------------------------
# VPC
# ------------------------------------------------------------------------------
module "vpc" {
  source = "git::https://github.com/Paulo-Rogerio/terraform-modules.git//cloudstack/vpc?ref=v0.0.2"

  name         = "test-vpc"
  cidr         = "10.0.0.0/16"
  vpc_offering = "Default VPC Offering"
  zone         = "zone-1"

}

