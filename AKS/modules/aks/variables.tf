variable "resource_group_name" {}
variable "location" {}
variable "cluster_name" {}
variable "default_node_pool_name" {
  default = "default"
}
variable "default_node_count" {
  default = 1
}
variable "default_node_pool_vm_size" {
  default = "Standard_DS2_v2"
}

variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster"
  type        = string
}
