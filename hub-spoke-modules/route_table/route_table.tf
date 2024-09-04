resource "azurerm_route_table" "route_table" {
  name                = var.route_table_config.name
  location            = var.route_table_config.location
  resource_group_name = var.route_table_config.resource_group_name
}