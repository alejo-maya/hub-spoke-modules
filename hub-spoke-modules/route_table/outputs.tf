output "route_table_name" {
  description = "Name of the Route Table"
  value       = azurerm_route_table.route_table.name
}

output "route_table_id" {
  description = "ID of the Route Table"
  value       = azurerm_route_table.route_table.id
}