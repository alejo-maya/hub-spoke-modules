variable "network" {
  description = "Spoke network configuration"
  type = object({
    vnet_name            = string
    subnet_name          = string
    hub_to_spoke_peering = string
    spoke_to_hub_peering = string
  })
  default = {
    vnet_name            = "spoke-vnet"
    subnet_name          = "spoke-subnet"
    hub_to_spoke_peering = "hub-to-spoke"
    spoke_to_hub_peering = "spoke-to-hub"
  }
}

variable "external" {
  description = "External variables passed to the module"
  type = object({
    spoke_name          = string
    location            = string
    resource_group_name = string
    hub_vnet_id         = string
    hub_vnet_name       = string
    address_space       = list(string)
    subnet_prefix       = list(string)
  })
}