resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    environment = var.environment
    managed-by  = "terraform"
  }
}

resource "azurerm_network_security_group" "security_group" {
  name                = "sg-vnet-${var.environment}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  tags = {
    environment = var.environment
    managed-by  = "terraform"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.environment}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  address_space       = var.address_space

  tags = {
    environment = var.environment
    managed-by  = "terraform"
  }
}

resource "azurerm_subnet" "subnet" {
  for_each = { for idx, subnet in var.subnets : idx => subnet }

  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes
}
