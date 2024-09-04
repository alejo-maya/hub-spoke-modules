module "aks_spoke" {
  source = "../spoke"

  external = {
    spoke_name          = "aks_spoke"
    location            = var.external.location
    resource_group_name = var.external.resource_group_name
    hub_vnet_id         = var.external.hub_vnet_id
    hub_vnet_name       = var.external.hub_vnet_name
    address_space       = var.network.vnet_address_space
    subnet_prefix       = var.network.subnet_prefix
  }
}

# networking.tf

# resource "azurerm_virtual_network" "aks_spoke_vnet" {
#   name                = var.network.vnet_name
#   location            = var.external.location
#   resource_group_name = var.external.resource_group_name
#   address_space       = var.network.vnet_address_space
#   dns_servers         = var.external.dns_servers
# }

# resource "azurerm_subnet" "aks_spoke_subnet" {
#   name                 = var.network.subnet_name
#   resource_group_name  = var.external.resource_group_name
#   virtual_network_name = azurerm_virtual_network.aks_spoke_vnet.name
#   address_prefixes     = var.network.subnet_prefix
# }

# resource "azurerm_virtual_network_peering" "hub_to_aks_spoke" {
#   name                      = var.network.hub_to_aks_peering_name
#   resource_group_name       = var.external.resource_group_name
#   virtual_network_name      = var.external.hub_vnet_name
#   remote_virtual_network_id = azurerm_virtual_network.aks_spoke_vnet.id
#   allow_forwarded_traffic   = true
#   allow_gateway_transit     = false
#   use_remote_gateways       = false
# }

# resource "azurerm_virtual_network_peering" "aks_spoke_to_hub" {
#   name                      = var.network.aks_to_hub_peering_name
#   resource_group_name       = var.external.resource_group_name
#   virtual_network_name      = azurerm_virtual_network.aks_spoke_vnet.name
#   remote_virtual_network_id = var.external.hub_vnet_id
#   allow_forwarded_traffic   = true
#   allow_gateway_transit     = false
#   use_remote_gateways       = false
# }
