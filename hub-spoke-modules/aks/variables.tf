variable "network" {
  description = "Network configuration for AKS"
  type = object({
    vnet_name               = string
    vnet_address_space      = list(string)
    subnet_name             = string
    subnet_prefix           = list(string)
    hub_to_aks_peering_name = string
    aks_to_hub_peering_name = string
  })
  default = {
    vnet_name               = "aks-spoke-vnet"
    vnet_address_space      = ["10.4.0.0/16"]
    subnet_name             = "aks-subnet"
    subnet_prefix           = ["10.4.1.0/24"]
    hub_to_aks_peering_name = "hub-to-aks-spoke"
    aks_to_hub_peering_name = "aks-spoke-to-hub"
  }
}

variable "aks" {
  description = "Configuration for the AKS cluster"
  type = object({
    name                    = string
    dns_prefix              = string
    node_pool_name          = string
    node_count              = number
    vm_size                 = string
    network_plugin          = string
    load_balancer_sku       = string
    private_cluster_enabled = bool
    identity_name           = string
  })
  default = {
    name                    = "private-aks-cluster"
    dns_prefix              = "privateaks"
    node_pool_name          = "agentpool"
    node_count              = 3
    vm_size                 = "Standard_DS2_v2"
    network_plugin          = "azure"
    load_balancer_sku       = "standard"
    private_cluster_enabled = true
    identity_name           = "aksidentity"
  }
}

variable "dns" {
  description = "Private DNS Zone configuration"
  type = object({
    private_dns_zone_name = string
    dns_link_spoke_name   = string
    dns_link_hub_name     = string
  })
  default = {
    private_dns_zone_name = "privatelink.eastus.azmk8s.io"
    dns_link_spoke_name   = "aks-private-dns-link"
    dns_link_hub_name     = "aks-private-dns-link-hub"
  }
}

variable "route_table" {
  description = "Route Table configuration"
  type = object({
    route_table_name = string
    route_name       = string
    address_prefix   = string
    next_hop_type    = string
  })
  default = {
    route_table_name = "aks-routes"
    route_name       = "aks-route"
    address_prefix   = "0.0.0.0/0"
    next_hop_type    = "VirtualAppliance"
  }
}

variable "external" {
  description = "External variables passed to the module"
  type = object({
    dns_server_ip       = string
    hub_vnet_name       = string
    hub_vnet_id         = string
    dns_servers         = list(string)
    location            = string
    resource_group_name = string
    resource_group_id   = string
    next_hop_ip_address = string
  })
}
