terraform {
  backend "azurerm" {
    resource_group_name  = "rg-n5-blob-storage"
    storage_account_name = "n5storageaccount"
    container_name       = "tfstates"
    key                  = "dev.vnet.tfstate"
  }
}
