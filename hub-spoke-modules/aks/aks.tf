resource "azurerm_user_assigned_identity" "base" {
  name                = var.aks.identity_name
  location            = var.external.location
  resource_group_name = var.external.resource_group_name
}

resource "azurerm_role_assignment" "base" {
  scope                = var.external.resource_group_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.base.principal_id
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks.name
  location            = var.external.location
  resource_group_name = var.external.resource_group_name
  dns_prefix          = var.aks.dns_prefix

  default_node_pool {
    name           = var.aks.node_pool_name
    node_count     = var.aks.node_count
    vm_size        = var.aks.vm_size
    vnet_subnet_id = module.aks_spoke.spoke_subnet_id
  }

  network_profile {
    network_plugin    = var.aks.network_plugin
    load_balancer_sku = var.aks.load_balancer_sku
  }

  private_cluster_enabled = var.aks.private_cluster_enabled
  private_dns_zone_id     = module.dns_zone.dns_zone_id

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.base.id]
  }

  depends_on = [module.dns_zone, azurerm_role_assignment.base]
}
