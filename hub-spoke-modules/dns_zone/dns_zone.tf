resource "azurerm_private_dns_zone" "dns_zone" {
  name                = var.dns_config.name
  resource_group_name = var.dns_config.resource_group_name
}