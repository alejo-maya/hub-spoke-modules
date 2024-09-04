variable "public_ip_config" {
  description = "Configuration for the Public IP."
  type = object({
    name                = string
    resource_group_name = string
    location            = string
  })
}