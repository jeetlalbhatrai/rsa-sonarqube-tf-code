resource "azurerm_virtual_network" "example" {
  name                = var.azurerm_virtual_network
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}


