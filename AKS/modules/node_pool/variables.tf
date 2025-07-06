variable "node_pools" {
  type = map(object({
    vm_size    = string
    node_count = number
  }))
}


variable "kubernetes_cluster_id" {
  description = "The ID of the AKS cluster"
  type        = string
}

variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group where the AKS cluster is located"
  type        = string
}