resource "azurerm_private_endpoint" "private_endpoint" {
  name                = var.pe_config.name
  location            = var.pe_config.location
  resource_group_name = var.pe_config.resource_group_name
  subnet_id           = var.pe_config.hub_subnet_id

  private_service_connection {
    name                           = var.pe_config.private_service_connection.name
    private_connection_resource_id = var.pe_config.private_service_connection.private_connection_resource_id
    is_manual_connection           = false
    subresource_names              = var.pe_config.private_service_connection.sub_resource_names
  }
}