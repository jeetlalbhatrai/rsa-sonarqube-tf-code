data "azurerm_key_vault" "example" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}
data "azurerm_client_config" "current" {}



resource "azurerm_key_vault" "example" {
  name                        = var.key_vault_name   
  location                    = var.resource_group_location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = false
  sku_name = "standard"
}

resource "azurerm_key_vault_secret" "example" {
    for_each     = var.key_vault_secrets
  name         = each.value.name
  value        = each.value.value
  key_vault_id = data.azurerm_key_vault.example.id
}