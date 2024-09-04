variable "route_config" {
  description = "Configuration for Routes"
  type = object({
    name                   = string
    resource_group_name    = string
    route_table_name       = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  })
}