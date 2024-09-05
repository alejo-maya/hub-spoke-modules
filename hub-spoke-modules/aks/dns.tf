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