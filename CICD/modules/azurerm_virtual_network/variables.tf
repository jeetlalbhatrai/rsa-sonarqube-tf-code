variable "azurerm_virtual_network" {
  type        = string
  default     = ""
  description = "description"
}
variable "resource_group_location" {
  type        = string
  default     = ""
  description = "The location of the resource group."
}
variable "resource_group_name" {
  type        = string
  default     = ""
  description = "The name of the resource group."
} 
variable "address_space"{
  description = "The address space for the virtual network."
  type        = list(string)
}