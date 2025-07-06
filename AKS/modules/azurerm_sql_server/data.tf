data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

# data "azurerm_key_vault_secret" "vm-username" {
#   name         = var.admin_user_name
#   key_vault_id = data.azurerm_key_vault.kv.id
# }

# data "azurerm_key_vault_secret" "vm-password" {
#   name         = var.admin_password_name
#   key_vault_id = data.azurerm_key_vault.kv.id
# }

data "azurerm_key_vault_secret" "secretname" {
  for_each = var.secretname
  name         = each.value.name
  key_vault_id = data.azurerm_key_vault.kv.id
}