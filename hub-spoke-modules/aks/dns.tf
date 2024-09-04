# resource "azurerm_private_dns_zone" "aks_private_zone" {
#   name                = var.dns.private_dns_zone_name
#   resource_group_name = var.external.resource_group_name
# }

module "dns_zone" {
  source = "../dns_zone"

  dns_config = {
    name                = var.dns.private_dns_zone_name
    resource_group_name = var.external.resource_group_name
  }
}

module "aks_dns_link_spoke" {
  source = "../dns_link"

  dns_link_config = {
    name                  = var.dns.dns_link_spoke_name
    resource_group_name   = var.external.resource_group_name
    private_dns_zone_name = module.dns_zone.dns_zone_name
    virtual_network_id    = module.aks_spoke.spoke_vnet_id
  }
}

module "aks_dns_link_hub" {
  source = "../dns_link"

  dns_link_config = {
    name                  = var.dns.dns_link_hub_name
    resource_group_name   = var.external.resource_group_name
    private_dns_zone_name = module.dns_zone.dns_zone_name
    virtual_network_id    = var.external.hub_vnet_id
  }
}

# resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_link_spoke" {
#   name                  = var.dns.dns_link_spoke_name
#   resource_group_name   = var.external.resource_group_name
#   private_dns_zone_name = azurerm_private_dns_zone.aks_private_zone.name
#   virtual_network_id    = azurerm_virtual_network.aks_spoke_vnet.id

#   depends_on = [azurerm_private_dns_zone.aks_private_zone]
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_link_hub" {
#   name                  = var.dns.dns_link_hub_name
#   resource_group_name   = var.external.resource_group_name
#   private_dns_zone_name = azurerm_private_dns_zone.aks_private_zone.name
#   virtual_network_id    = var.external.hub_vnet_id

#   depends_on = [azurerm_private_dns_zone.aks_private_zone]
# }
