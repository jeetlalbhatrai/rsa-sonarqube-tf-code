resource "azurerm_kubernetes_cluster_node_pool" "nodepool" {
  for_each = var.node_pools

  name                  = each.key
    kubernetes_cluster_id = var.kubernetes_cluster_id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  os_type               = "Linux"
}