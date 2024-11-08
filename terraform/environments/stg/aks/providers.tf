terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.9.0"
    }
  }
}

provider "azurerm" {
  features {}
  client_id                   = var.client_id
  client_certificate_password = var.client_certificate_password
  client_certificate          = var.client_certificate
  subscription_id             = var.subscription_id
  tenant_id                   = var.tenant_id
}
