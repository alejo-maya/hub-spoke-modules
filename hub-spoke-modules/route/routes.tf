resource "azurerm_route" "route" {
  name                   = var.route_config.name
  resource_group_name    = var.route_config.resource_group_name
  route_table_name       = var.route_config.route_table_name
  address_prefix         = var.route_config.address_prefix
  next_hop_type          = var.route_config.next_hop_type
  next_hop_in_ip_address = var.route_config.next_hop_in_ip_address
}