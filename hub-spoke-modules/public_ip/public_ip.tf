resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_config.name
  location            = var.public_ip_config.location
  resource_group_name = var.public_ip_config.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}