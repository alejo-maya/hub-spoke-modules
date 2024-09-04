output "nic_private_ip_address" {
  description = "Private IP Address of the NIC"
  value       = azurerm_network_interface.nic.private_ip_address
}
