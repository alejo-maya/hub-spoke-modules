variable "dns_config" {
  description = "Configuration for the DNS Zone."
  type = object({
    resource_group_name = string
    name                = string
  })
}