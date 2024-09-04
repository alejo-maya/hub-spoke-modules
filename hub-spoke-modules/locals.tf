locals {
  vm_configs = {
    vm1 = {
      location            = var.location
      resource_group_name = azurerm_resource_group.rg.name
      subnet_id           = module.spoke["spoke1"].spoke_subnet_id
      vm_name             = "vm1"
      admin_credentials = {
        username = "adminuser"
        password = ""
      }
      vm_size      = "Standard_DS1_v2"
      os_disk_name = "osdisk-vm1"
      os_image = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
      }
    }
    vm2 = {
      location            = var.location
      resource_group_name = azurerm_resource_group.rg.name
      subnet_id           = module.spoke["spoke2"].spoke_subnet_id
      vm_name             = "vm2"
      admin_credentials = {
        username = "adminuser"
        password = ""
      }
      vm_size      = "Standard_DS2_v2"
      os_disk_name = "osdisk-vm2"
      os_image = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
      }
    }
    vm3 = {
      location            = var.location
      resource_group_name = azurerm_resource_group.rg.name
      subnet_id           = module.hub.hub_subnet_id
      vm_name             = "vm3"
      admin_credentials = {
        username = "adminuser"
        password = ""
      }
      vm_size      = "Standard_DS3_v2"
      os_disk_name = "osdisk-vm3"
      os_image = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
      }
    }
  }

  dns_links = {
    hub_vnet_link = {
      name               = "hub-vnet-link"
      virtual_network_id = module.hub.hub_vnet_id
    }
    spoke1_vnet_link = {
      name               = "spoke1-vnet-link"
      virtual_network_id = module.spoke["spoke1"].spoke_vnet_id
    }
    spoke2_vnet_link = {
      name               = "spoke2-vnet-link"
      virtual_network_id = module.spoke["spoke2"].spoke_vnet_id
    }
  }

  dns_a_records = {
    spoke1vm = {
      name    = "spoke1vm"
      records = [module.vm["vm1"].nic_private_ip_address]
    }
    spoke2vm = {
      name    = "spoke2vm"
      records = [module.vm["vm2"].nic_private_ip_address]
    }
    hubvm = {
      name    = "hubvm"
      records = [module.vm["vm3"].nic_private_ip_address]
    }
  }

  route_associations = {
    spoke1 = {
      subnet_id      = module.spoke["spoke1"].spoke_subnet_id
      route_table_id = module.route_table.route_table_id
    }
    spoke2 = {
      subnet_id      = module.spoke["spoke2"].spoke_subnet_id
      route_table_id = module.route_table.route_table_id
    }
    hub = {
      subnet_id      = module.hub.hub_subnet_id
      route_table_id = module.route_table.route_table_id
    }
  }

  dns_zones = {
    dns_config_vms = {
      resource_group_name = azurerm_resource_group.rg.name
      name                = "localtechtitans.com"
    }
    dns_config_sa = {
      resource_group_name = azurerm_resource_group.rg.name
      name                = "privatelink.blob.core.windows.net"
    }
  }

}