variable "location" {
  description = "The location/region where the infrastructure will be deployed."
  type        = string
  default     = "West Europe"
}

variable "environment" {
  description = "The environment the resources belong to"
  type        = string
  default     = "stg"
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
