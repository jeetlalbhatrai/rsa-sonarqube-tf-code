resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [each.value.address_prefix]
}

output "subnet_ids" {
  value = { for key, subnet in azurerm_subnet.subnet : key => subnet.id }
}