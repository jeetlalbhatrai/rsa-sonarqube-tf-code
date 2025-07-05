data "azurerm_subnet" "rsa-subnet" {
  name                 = var.rsa_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_public_ip" "rsa_public_ip" {
  name                = var.public_ip_address_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_secret" "secretname" {
  for_each = var.secretname
  name         = each.value
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_network_security_group" "existing_nsg" {
  name                = var.nsg_name           
  resource_group_name = var.resource_group_name              
}
