variable "location" {
  description = "Location for all resources"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "sw-tt-amaya-private-networking-test-002"
}

variable "spokes" {
  type = map(object({
    name          = string
    address_space = list(string)
    subnet_prefix = list(string)
  }))
}