variable "route_table_config" {
  description = "Configuration for Route Table"
  type = object({
    name                = string
    location            = string
    resource_group_name = string
  })
}