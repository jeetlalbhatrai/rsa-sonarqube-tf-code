variable "subnet_name" {
  type        = string
  default     = ""
  description = "description"
}

variable "resource_group_name" {
  type        = string
  default     = ""
  description = "The name of the resource group in which to create the subnet."
}
variable "virtual_network_name" {
  type        = string
  default     = ""
  description = "The name of the virtual network in which to create the subnet."
}
variable "address_prefixes" {
  type        = list(string)
  default     = []
  description = "The address prefixes to use for the subnet."
}