variable "firewall_config" {
  description = "Configuration for the Firewall."
  type = object({
    name                 = string
    resource_group_name  = string
    location             = string
    virtual_network_name = string
    address_prefixes     = list(string)
  })
}