resource "azurerm_mssql_server" "example" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.resource_group_location
  version                      = var.sql_server_version
  administrator_login          = data.azurerm_key_vault_secret.secretname["vm_username"].value
  administrator_login_password = data.azurerm_key_vault_secret.secretname["vm_password"].value
}


