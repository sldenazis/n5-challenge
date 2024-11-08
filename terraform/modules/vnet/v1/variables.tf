variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "vnet"
}

variable "location" {
  description = "The location/region where the infrastructure will be deployed."
  type        = string
  default     = "West Europe"
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
  type        = string
}

variable "environment" {
  description = "The environment the resources belong to"
  type        = string
}

variable "address_space" {
  description = "The address space that is used the virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "list of subnets"
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
}
