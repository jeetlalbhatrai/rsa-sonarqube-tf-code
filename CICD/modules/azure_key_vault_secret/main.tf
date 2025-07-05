data "azurerm_key_vault" "example" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_key_vault_secret" "example" {
  for_each     = var.key_vault_secrets
  name         = each.value.name
  value        = each.value.value
  key_vault_id = data.azurerm_key_vault.example.id
}