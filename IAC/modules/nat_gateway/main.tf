resource "azurerm_public_ip" "pip" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "ngw" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"
  #  public_ip_address_ids    = azurerm_public_ip.pip.id
}
resource "azurerm_nat_gateway_public_ip_association" "example" {
  nat_gateway_id       = azurerm_nat_gateway.ngw.id
  public_ip_address_id = azurerm_public_ip.pip.id
}

resource "azurerm_subnet_nat_gateway_association" "assoc" {
  subnet_id      = var.subnet_id
  nat_gateway_id = azurerm_nat_gateway.ngw.id
}
