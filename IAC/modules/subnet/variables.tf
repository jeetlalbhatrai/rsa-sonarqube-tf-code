variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "rg_name" {
  type = string
} 

variable "vnet_name" {
  type = string
}