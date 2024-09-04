resource "azurerm_private_dns_a_record" "dns_a_record" {
  name                = var.dns_a_record_config.name
  resource_group_name = var.dns_a_record_config.resource_group_name
  zone_name           = var.dns_a_record_config.zone_name
  ttl                 = 300
  records             = var.dns_a_record_config.records
}