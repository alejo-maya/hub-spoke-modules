resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = var.dns_link_config.name
  resource_group_name   = var.dns_link_config.resource_group_name
  private_dns_zone_name = var.dns_link_config.private_dns_zone_name
  virtual_network_id    = var.dns_link_config.virtual_network_id
}