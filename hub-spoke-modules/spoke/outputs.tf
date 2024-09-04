output "spoke_vnet_id" {
  description = "ID of the Spoke VNet"
  value       = azurerm_virtual_network.spoke_vnet.id
}

output "spoke_subnet_id" {
  description = "ID of the Spoke Subnet"
  value       = azurerm_subnet.spoke_subnet.id
}