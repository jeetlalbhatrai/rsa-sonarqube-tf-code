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

variable "key_vault_secrets" {
  description = "Map of secret blocks, each with a name and value"
  type = map(object({
    name  = string
    value = string
  }))
}

