variable "sql_server_name" {
  type        = string
  default     = ""
  description = "description"
}   
variable "resource_group_name" {
  type        = string
  default     = ""
  description = "The name of the resource group in which the SQL Server will be created."
}
variable "resource_group_location" {
  type        = string
  default     = ""
  description = "The location of the resource group in which the SQL Server will be created."
}
variable "sql_server_version" {
  type        = string
  default     = "12.0"
  description = "The version of the SQL Server."
}
variable "administrator_login" {
  type        = string
  default     = "sqladmin"
  description = "The administrator login for the SQL Server."
}
variable "administrator_login_password" {
  type        = string
  default     = "Password@123"
  description = "The password for the SQL Server administrator login."
}

variable "key_vault_name" {
  type        = string
  default     = ""
  description = "The name of the Key Vault where secrets are stored."
}
variable "secretname" {
  type        = map(any)
  description = "The name of the admin user for the SQL Server."
}
# variable "admin_password_name" {
#   type        = string
#   default     = "password"
#   description = "The name of the admin password for the SQL Server."
# }
