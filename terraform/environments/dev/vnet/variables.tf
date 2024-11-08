variable "location" {
  description = "The location/region where the infrastructure will be deployed."
  type        = string
  default     = "West Europe"
}

variable "environment" {
  description = "The environment the resources belong to"
  type        = string
  default     = "dev"
}

variable "address_space" {
  description = "The address space that is used the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "list of subnets"
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
  default = [
    {
      name             = "aks-subnet"
      address_prefixes = ["10.0.0.0/24"]
  }]
}

variable "client_id" {
  description = "The client id of the service principal"
  type        = string
}

variable "client_certificate_password" {
  description = "The password of the service principal"
  type        = string
}

variable "client_certificate" {
  description = "The certificate of the service principal"
  type        = string
}

variable "subscription_id" {
  description = "The subscription id"
  type        = string
}

variable "tenant_id" {
  description = "The tenant id"
  type        = string
}
