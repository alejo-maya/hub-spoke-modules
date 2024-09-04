variable "dns_link_config" {
  description = "Configuration for the DNS Zone."
  type = object({
    name                  = string
    resource_group_name   = string
    private_dns_zone_name = string
    virtual_network_id    = string
  })
}