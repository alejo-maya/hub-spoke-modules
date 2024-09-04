module "hub" {
  source = "./hub"

  external = {
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name
  }
}

module "spoke" {
  for_each = var.spokes

  source = "./spoke"

  external = {
    spoke_name          = each.value.name
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name
    hub_vnet_id         = module.hub.hub_vnet_id
    hub_vnet_name       = module.hub.hub_vnet_name
    address_space       = each.value.address_space
    subnet_prefix       = each.value.subnet_prefix
  }
}

module "vm" {
  for_each  = local.vm_configs
  source    = "./vm"
  vm_config = each.value
}

module "bastion" {
  source = "./bastion"

  bastion_config = {
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name
    vnet_name           = module.hub.hub_vnet_name
    bastion_name        = "hub-bastion"
    address_prefixes    = ["10.0.4.0/27"]
  }
}

module "dns_zone" {
  for_each = local.dns_zones
  source   = "./dns_zone"

  dns_config = {
    resource_group_name = azurerm_resource_group.rg.name
    name                = each.value.name
  }
}

module "dns_link" {
  for_each = local.dns_links

  source = "./dns_link"

  dns_link_config = {
    name                  = each.value.name
    resource_group_name   = azurerm_resource_group.rg.name
    private_dns_zone_name = module.dns_zone["dns_config_vms"].dns_zone_name
    virtual_network_id    = each.value.virtual_network_id
  }
}

module "dns_a_record" {
  for_each = local.dns_a_records
  source   = "./dns_a_record"

  dns_a_record_config = {
    name                = each.value.name
    resource_group_name = azurerm_resource_group.rg.name
    zone_name           = module.dns_zone["dns_config_vms"].dns_zone_name
    records             = each.value.records
  }
}

module "firewall_dns" {
  source = "./firewall_dns"

  firewall_config = {
    name                 = "firewall"
    resource_group_name  = azurerm_resource_group.rg.name
    location             = var.location
    virtual_network_name = module.hub.hub_vnet_name
    address_prefixes     = ["10.0.3.0/24"]
  }
}

module "route_table" {
  source = "./route_table"

  route_table_config = {
    name                = "route-table"
    resource_group_name = azurerm_resource_group.rg.name
    location            = var.location
  }
}

module "route" {
  source = "./route"

  route_config = {
    name                   = "route-to-firewall"
    resource_group_name    = azurerm_resource_group.rg.name
    route_table_name       = module.route_table.route_table_name
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = module.firewall_dns.firewall_private_ip
  }
}

module "route_table_association" {
  for_each = local.route_associations
  source   = "./route_table_association"

  route_table_association_config = {
    subnet_id      = each.value.subnet_id
    route_table_id = each.value.route_table_id
  }
}

module "aks" {
  source = "./aks"

  external = {
    dns_server_ip       = module.firewall_dns.firewall_private_ip
    hub_vnet_id         = module.hub.hub_vnet_id
    hub_vnet_name       = module.hub.hub_vnet_name
    dns_servers         = [module.firewall_dns.firewall_private_ip]
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name
    resource_group_id   = azurerm_resource_group.rg.id
    next_hop_ip_address = module.firewall_dns.firewall_private_ip
  }
}

module "storage_account_pe" {
  source = "./storage_account_pe"

  sa_config = {
    name                  = "testpestorageacct001"
    location              = var.location
    resource_group_name   = azurerm_resource_group.rg.name
    hub_subnet_id         = module.hub.hub_subnet_id
    hub_vnet_id           = module.hub.hub_vnet_id
    hub_vnet_name         = module.hub.hub_vnet_name
    private_dns_zone_name = module.dns_zone["dns_config_sa"].dns_zone_name
  }
}