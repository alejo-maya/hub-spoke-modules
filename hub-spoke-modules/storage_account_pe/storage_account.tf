resource "azurerm_storage_account" "sa" {
  name                     = var.sa_config.name
  resource_group_name      = var.sa_config.resource_group_name
  location                 = var.sa_config.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    ip_rules                   = []
    virtual_network_subnet_ids = [var.sa_config.hub_subnet_id]
  }

  public_network_access_enabled = false
}

module "private_endpoint" {
  source = "../private_endpoint"

  pe_config = {
    name                = "pe-${var.sa_config.name}"
    resource_group_name = var.sa_config.resource_group_name
    location            = var.sa_config.location
    hub_subnet_id       = var.sa_config.hub_subnet_id
    private_service_connection = {
      name                           = "psc-pe-${var.sa_config.name}"
      private_connection_resource_id = azurerm_storage_account.sa.id
      sub_resource_names             = ["blob"]
    }
  }
}

module "dns_link" {
  source = "../dns_link"

  dns_link_config = {
    name                  = "dnslink-${var.sa_config.name}"
    resource_group_name   = var.sa_config.resource_group_name
    private_dns_zone_name = var.sa_config.private_dns_zone_name
    virtual_network_id    = var.sa_config.hub_vnet_id
  }
}

module "dns_a_record" {
  source = "../dns_a_record"

  dns_a_record_config = {
    name                = "dns-a${var.sa_config.name}"
    resource_group_name = var.sa_config.resource_group_name
    zone_name           = var.sa_config.private_dns_zone_name
    records             = [module.private_endpoint.private_service_connection_private_ip]
  }
}