variable "route_table_association_config" {
  description = "Configuration for Route Table Association"
  type = object({
    subnet_id      = string
    route_table_id = string
  })
}