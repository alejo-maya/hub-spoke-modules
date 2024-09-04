output "private_service_connection_private_ip" {
  description = "Private IP of the private service connection"
  value       = azurerm_private_endpoint.private_endpoint.private_service_connection.0.private_ip_address
}