variable "public_ip_name" {
  type        = string
  default     = ""
  description = "description"
}
variable "resource_group_name" {
  type        = string
  default     = ""
  description = "The name of the resource group in which to create the Public IP."
}
variable "resource_group_location" {
  type        = string
  default     = ""
  description = "The location of the resource group in which to create the Public IP."
}
variable "allocation_method" {
  type        = string
  default     = "Static"
  description = "The allocation method for the Public IP. Can be 'Static' or 'Dynamic'."
}