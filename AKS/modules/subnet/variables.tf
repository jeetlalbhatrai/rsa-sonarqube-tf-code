variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name for the Subnets"
  type        = string
}

variable "subnets" {
  description = "Map of subnets to create"
  type = map(object({
    name           = string
    address_prefix = string
  }))
}