variable "network" {
  description = "Hub network configuration"
  type = object({
    vnet_name     = string
    address_space = list(string)
    dns_servers   = list(string)
    subnet_name   = string
    subnet_prefix = list(string)
  })
  default = {
    vnet_name     = "hub-vnet"
    address_space = ["10.0.0.0/16"]
    dns_servers   = []
    subnet_name   = "hub-subnet"
    subnet_prefix = ["10.0.1.0/24"]
  }
}

variable "external" {
  description = "External variables passed to the module"
  type = object({
    location            = string
    resource_group_name = string
  })
}