resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.resource_group_location
}


output "resource_group_location" {
  value = azurerm_resource_group.example.location
}

output "resource_group_name" {
  value = azurerm_resource_group.example.name
}
