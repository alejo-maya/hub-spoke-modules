variable "pe_config" {
  description = "External variables passed to the module"
  type = object({
    name                = string
    location            = string
    resource_group_name = string
    hub_subnet_id       = string
    private_service_connection = object({
      name                           = string
      private_connection_resource_id = string
      sub_resource_names             = list(string)
    })
  })
}