module "route_table" {
  source = "../route_table"

  route_table_config = {
    name                = var.route_table.route_table_name
    location            = var.external.location
    resource_group_name = var.external.resource_group_name
  }
}

module "route" {
  source = "../route"

  route_config = {
    resource_group_name    = var.external.resource_group_name
    route_table_name       = module.route_table.route_table_name
    name                   = var.route_table.route_name
    address_prefix         = var.route_table.address_prefix
    next_hop_type          = var.route_table.next_hop_type
    next_hop_in_ip_address = var.external.next_hop_ip_address
  }
}

module "route_table_association" {
  source = "../route_table_association"

  route_table_association_config = {
    subnet_id      = module.aks_spoke.spoke_subnet_id
    route_table_id = module.route_table.route_table_id
  }
}

# route_table.tf
# resource "azurerm_route_table" "aks_route_table" {
#   name                = var.route_table.route_table_name
#   location            = var.external.location
#   resource_group_name = var.external.resource_group_name

#   route {
#     name                   = var.route_table.route_name
#     address_prefix         = var.route_table.address_prefix
#     next_hop_type          = var.route_table.next_hop_type
#     next_hop_in_ip_address = var.external.next_hop_ip_address
#   }
# }

# resource "azurerm_subnet_route_table_association" "aks_subnet_association" {
#   subnet_id      = azurerm_subnet.aks_spoke_subnet.id
#   route_table_id = azurerm_route_table.aks_route_table.id
# }

