resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    environment = var.environment
    managed-by  = "terraform"
  }
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.cluster_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = var.cluster_name

  default_node_pool {
    name       = "default"
    node_count = var.default_node_pool_count
    vm_size    = var.default_node_pool_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = var.environment
    managed-by  = "terraform"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "extra_node_pools" {
  for_each = { for idx, pool in var.extra_node_pools : idx => pool }

  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  name            = each.value.name
  node_count      = each.value.node_count
  vm_size         = each.value.vm_size
}
