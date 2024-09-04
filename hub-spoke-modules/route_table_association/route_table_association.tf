resource "azurerm_subnet_route_table_association" "rt_association" {
  subnet_id      = var.route_table_association_config.subnet_id
  route_table_id = var.route_table_association_config.route_table_id
}