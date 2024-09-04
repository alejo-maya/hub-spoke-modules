resource "azurerm_virtual_network" "hub_vnet" {
  name                = var.network.vnet_name
  location            = var.external.location
  resource_group_name = var.external.resource_group_name
  address_space       = var.network.address_space
  dns_servers         = var.network.dns_servers
}

resource "azurerm_subnet" "hub_subnet" {
  name                 = var.network.subnet_name
  resource_group_name  = var.external.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = var.network.subnet_prefix

  service_endpoints = ["Microsoft.Storage"]
}
