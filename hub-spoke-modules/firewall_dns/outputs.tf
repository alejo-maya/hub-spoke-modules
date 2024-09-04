output "firewall_private_ip" {
  description = "Private IP of the Firewall"
  value       = azurerm_firewall.main.ip_configuration.0.private_ip_address
}