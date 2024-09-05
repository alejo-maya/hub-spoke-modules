module "aks_spoke" {
  source = "../spoke"

  external = {
    spoke_name          = "aks_spoke"
    location            = var.external.location
    resource_group_name = var.external.resource_group_name
    hub_vnet_id         = var.external.hub_vnet_id
    hub_vnet_name       = var.external.hub_vnet_name
    address_space       = var.network.vnet_address_space
    subnet_prefix       = var.network.subnet_prefix
  }
}
