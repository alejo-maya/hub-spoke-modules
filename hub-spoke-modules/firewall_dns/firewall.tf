module "public_ip" {
  source = "../public_ip"

  public_ip_config = {
    name                = "firewall-public-ip"
    resource_group_name = var.firewall_config.resource_group_name
    location            = var.firewall_config.location
  }
}

resource "azurerm_subnet" "firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.firewall_config.resource_group_name
  virtual_network_name = var.firewall_config.virtual_network_name
  address_prefixes     = var.firewall_config.address_prefixes
}

resource "azurerm_firewall" "main" {
  name                = var.firewall_config.name
  location            = var.firewall_config.location
  resource_group_name = var.firewall_config.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    public_ip_address_id = module.public_ip.public_ip_id
    subnet_id            = azurerm_subnet.firewall_subnet.id
  }

  dns_proxy_enabled = true
}


resource "azurerm_firewall_network_rule_collection" "network_rules" {
  name                = "firewall-rule-collection"
  azure_firewall_name = azurerm_firewall.main.name
  resource_group_name = var.firewall_config.resource_group_name
  priority            = 100
  action              = "Allow"

  rule {
    name                  = "allow-all"
    protocols             = ["Any"]
    source_addresses      = ["10.0.0.0/8"]
    destination_addresses = ["*"]
    destination_ports     = ["*"]
  }
}