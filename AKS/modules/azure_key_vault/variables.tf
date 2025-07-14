variable "key_vault_name" {
  type        = string
  default     = ""
  description = "description"
}   

variable "resource_group_name" {
  type        = string
  default     = ""
  description = "Resource group name"
}
variable "resource_group_location" {
  type        = string
  default     = ""
  description = "Resource group location"
}
variable "tenant_id" {
  type        = string
  default     = ""
  description = "Tenant ID for the Key Vault"
}   
variable "soft_delete_retention_days" {
  type        = number
  default     = 7
  description = "Number of days to retain soft-deleted Key Vaults"
}

variable "key_vault_secrets" {
  type        = map(any)
  description = "Name of the Key Vault secret"
}

# variable "key_vault_id" {
#   type        = string
#   default     = ""
#   description = "ID of the Key Vault
#   }