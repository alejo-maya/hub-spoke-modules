variable "sa_config" {
  description = "Configuration for Storage Account"
  type = object({
    name                  = string
    location              = string
    resource_group_name   = string
    hub_subnet_id         = string
    hub_vnet_id           = string
    hub_vnet_name         = string
    private_dns_zone_name = string
  })
}