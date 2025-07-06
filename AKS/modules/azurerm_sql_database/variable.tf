variable  "database_name" {
  type        = string
  default     = ""
  description = "description"
}
variable "server_id" {
  type        = string
  default     = ""
  description = "description"
}
variable "collation" {
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
  description = "The collation of the database."
}
variable "license_type" {
  type        = string
  default     = "LicenseIncluded"
  description = "The license type of the database."
}
variable "max_size_gb" {
  type        = number
  default     = 32
  description = "The maximum size of the database in GB."
}
variable "sku_name" {
  type        = string
  default     = "GP_S_Gen5_2"
  description = "The SKU name of the database."
}

variable "sql_server_name" {
  type        = string
  default     = ""
  description = "The name of the SQL server."
}
variable "resource_group_name" {
  type        = string
  default     = ""
  description = "The name of the resource group."
}