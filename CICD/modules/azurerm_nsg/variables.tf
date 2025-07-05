variable "nsg_name" {
  type        = string
  default     = ""
  description = "The name of the Network Security Group to be created."
}

variable "resource_group_name" {
  type        = string
  default     = ""
  description = "The name of the resource group in which to create the Network Security Group."
}

variable "resource_group_location" {
  type        = string
  default     = ""
  description = "The location of the resource group in which to create the Network Security Group."
}

variable "security_rules" {
  description = "List of security rules to be applied to the Network Security Group"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}


