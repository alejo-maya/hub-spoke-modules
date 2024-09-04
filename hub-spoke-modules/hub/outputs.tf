output "hub_vnet_id" {
  description = "ID of the Hub VNet"
  value       = azurerm_virtual_network.hub_vnet.id
}

output "hub_vnet_name" {
  description = "Name of the Hub VNet"
  value       = azurerm_virtual_network.hub_vnet.name
}

output "hub_subnet_id" {
  description = "ID of the Hub Subnet"
  value       = azurerm_subnet.hub_subnet.id
}