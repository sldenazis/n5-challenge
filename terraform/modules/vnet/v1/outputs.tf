output "vnet_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
  value       = var.resource_group_name
}
