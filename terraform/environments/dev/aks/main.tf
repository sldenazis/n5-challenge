module "aks" {
  source                    = "../../../modules/aks-cluster/v1"
  cluster_name              = "aks-${var.environment}"
  resource_group_name       = "rg-aks-${var.environment}"
  location                  = var.location
  environment               = var.environment
  default_node_pool_count   = 1
  default_node_pool_vm_size = "standard_b2pls_v2"
  extra_node_pools          = []
}
