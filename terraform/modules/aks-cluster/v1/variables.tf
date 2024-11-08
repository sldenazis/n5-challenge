variable "location" {
  description = "The region in which the resources will be created"
  default     = "West Europe"
  type        = string
}

variable "cluster_name" {
  description = "The name of the AKS cluster"
  default     = "aks-cluster"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
  type        = string
}

variable "environment" {
  description = "The environment the resources belong to"
  type        = string
}

variable "default_node_pool_count" {
  description = "The number of nodes in the default node pool"
  default     = 1
  type        = number
}

variable "default_node_pool_vm_size" {
  description = "The size of the VMs in the default node pool"
  default     = "Standard_D2_v2"
  type        = string
}

variable "extra_node_pools" {
  description = "List of maps containing the configuration of the extra node pools"

  type = list(object({
    name       = string
    node_count = number
    vm_size    = string
  }))

  default = []
}
