variable "network_nic_name" {
  type        = string
  default     = ""
  description = "The name of the network interface to be created for the virtual machine."
}

variable "subnet_id" {
  type        = string
  default     = ""
  description = "description"
}

variable "vm_name" {
  type        = string
  default     = ""
  description = "description"
}

variable "resource_group_name" {
  type        = string
  default     = ""
  description = "The name of the resource group in which to create the virtual machine."
}
variable "resource_group_location" {
  type        = string
  default     = ""
  description = "The location of the resource group in which to create the virtual machine."
}
variable "vm_size" {
  type        = string
  default     = "Standard_B1s"
  description = "The size of the virtual machine."
}
variable "os_publisher" {
  type        = string
  default     = "Canonical"
  description = "The publisher of the operating system image."
}
variable "os_offer" {
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
  description = "The offer of the operating system image."
}
variable "os_sku" {
  type        = string
  default     = "22_04-lts"
  description = "The SKU of the operating system image."
}
variable "os_version" {
  type        = string
  default     = "latest"
  description = "The version of the operating system image."
}
variable "admin_user_name" {
  type        = string
  default     = ""
  description = "The username for the administrator account."
}
variable "admin_password" {
  type        = string
  default     = ""
  description = "The password for the administrator account."
}
variable "public_ip_address_name" {
  type        = string
  default     = ""
  description = "The ID of the public IP address to associate with the virtual machine."
}

variable "rsa_subnet_name" {
  type        = string
  default     = ""
  description = "The name of the frontend subnet in which to create the virtual machine."
}
variable "virtual_network_name" {
  type        = string
  default     = ""
  description = "The name of the virtual network in which to create the virtual machine."
}

variable "key_vault_name" {
  type        = string
  default     = ""
  description = "The name of the Key Vault to use for storing secrets."
}

variable "secretname" {
  type        = map(any)
  description = "The name of the Key Vault secret that contains the administrator password."
}

variable "custom_data" {
  type        = string
  default     = ""
  description = "Custom data to be passed to the virtual machine at creation time, typically used for cloud-init scripts."
}

variable "nsg_name" {
  type        = string
  default     = ""
  description = "The name of the Network Security Group to associate with the virtual machine's network interface."
}
