module "vnet" {
  source              = "../../../modules/vnet/v1"
  resource_group_name = "rg-vnet-${var.environment}"
  location            = var.location
  environment         = var.environment
  address_space       = var.address_space
  subnets             = var.subnets
  vnet_name           = "vnet-${var.environment}"
}
