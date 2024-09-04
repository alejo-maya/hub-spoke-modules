resource "azurerm_virtual_network" "spoke_vnet" {
  name                = "${var.external.spoke_name}-${var.network.vnet_name}"
  location            = var.external.location
  resource_group_name = var.external.resource_group_name
  address_space       = var.external.address_space
}

resource "azurerm_subnet" "spoke_subnet" {
  name                 = var.network.subnet_name
  resource_group_name  = var.external.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke_vnet.name
  address_prefixes     = var.external.subnet_prefix
}

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = "${var.network.hub_to_spoke_peering}-${var.external.spoke_name}"
  resource_group_name       = var.external.resource_group_name
  virtual_network_name      = var.external.hub_vnet_name
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet.id
  allow_forwarded_traffic   = true
  use_remote_gateways       = false
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = var.network.spoke_to_hub_peering
  resource_group_name       = var.external.resource_group_name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet.name
  remote_virtual_network_id = var.external.hub_vnet_id
  allow_forwarded_traffic   = true
  use_remote_gateways       = false
}
