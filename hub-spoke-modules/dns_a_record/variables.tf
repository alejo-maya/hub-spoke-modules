variable "dns_a_record_config" {
  description = "Configuration for the DNS A Records."
  type = object({
    name                = string
    resource_group_name = string
    zone_name           = string
    records             = list(string)
  })
}