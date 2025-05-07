# ------------------------------------------------------------------------------
# ENVIRONMENT
# ------------------------------------------------------------------------------
variable "name" {
  description = "The environment name"
  type        = string
}

variable "zone" {
  description = "Name or ID of the zone where the VPC should be deployed"
  type        = string
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by CS and should be overridden"
  type        = string
  default     = "0.0.0.0/0"
}

variable "vpc_offering" {
  description = "The name or ID of the VPC offering to use for this VPC. Changing this forces a new resource to be created."
  type        = string
  default     = ""
}

variable "network_domain" {
  description = "The default DNS domain for networks created in this VPC. Changing this forces a new resource to be created."
  type        = string
  default     = ""
}

variable "project" {
  description = "The name or ID of the project to deploy this instance to. Changing this forces a new resource to be created."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "subnets" {
  description = "A list of subnets/tiers inside the VPC"
  type        = list(string)
  default     = []
}

variable "subnet_names" {
  description = "A list of subnets/tiers names"
  type        = list(string)
  default     = []
}

variable "default_network_offering" {
  description = "Network offering that should be used, if not list is specified"
  type        = string
  default     = ""
}

variable "subnet_offerings" {
  description = "A list of cs networkoffering that should be used"
  type        = list(string)
  default     = []
}

variable "network_acl_ids" {
  type        = list(string)
  description = "A list of network ACL ids."
  default     = []
}

variable "default_network_acl_id" {
  description = "Network ACL id that should be used, if not list is specified"
  type        = string
  default     = ""
}
