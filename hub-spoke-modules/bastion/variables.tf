variable "bastion_config" {
  description = "Configuration for the Bastion."
  type = object({
    location            = string
    resource_group_name = string
    vnet_name           = string
    bastion_name        = string
    address_prefixes    = list(string)
  })
}