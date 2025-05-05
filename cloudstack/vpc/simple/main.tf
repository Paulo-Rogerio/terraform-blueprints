
# ------------------------------------------------------------------------------
# VPC
# ------------------------------------------------------------------------------
module "vpc" {
  source = "git::https://github.com/Paulo-Rogerio/terraform-modules?ref=main/tree/main/cloudstack/vpc"

  name         = "test-vpc"
  cidr         = "10.0.0.0/16"
  vpc_offering = "Default VPC Offering"
  zone         = "zone-1"

}

