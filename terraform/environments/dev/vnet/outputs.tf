output "vnet_id" {
  description = "The ID of the virtual network"
  value       = module.vnet.vnet_id
}

output "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
  value       = module.vnet.resource_group_name
}
