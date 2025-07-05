variable "location" { type = string }
variable "rg_name" { type = string }
variable "vnet_name" { type = string }

variable "vnet_cidr" {
  type        = list(string)
  description = "Top‑level VNet CIDR, e.g. [\"10.0.0.0/16\"]"
}

variable "subnets" {
  description = "Map of subnet blocks keyed by tier"
  type = map(object({
    address_prefixes = list(string)
  }))
}

# variable "location"   { type = string }
# variable "rg_name"    { type = string }
# variable "vnet_name"  { type = string }

# variable "vnet_cidr" {
#   type        = list(string)
#   description = "Address space for the VNet"
# }

# variable "subnets" {
#   type = map(object({
#     address_prefixes = list(string)
#   }))
# }

# --- NEW: pass straight through to the NSG child module
variable "nsgs" {
  type = map(object({
    inbound_rules = list(object({
      name                    = string
      priority                = number
      direction               = string
      access                  = string
      protocol                = string
      source_address_prefixes = list(string)
      destination_port_ranges = list(string)
    }))
  }))
}

variable "nat_gateway_name" {
  type        = string
  description = "Name of the NAT Gateway"
}