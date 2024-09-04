resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_config.vm_name}-nic"
  location            = var.vm_config.location
  resource_group_name = var.vm_config.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.vm_config.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = var.vm_config.vm_name
  location              = var.vm_config.location
  resource_group_name   = var.vm_config.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = var.vm_config.vm_size

  storage_os_disk {
    name              = var.vm_config.os_disk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.vm_config.vm_name
    admin_username = var.vm_config.admin_credentials.username
    admin_password = var.vm_config.admin_credentials.password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_image_reference {
    publisher = var.vm_config.os_image.publisher
    offer     = var.vm_config.os_image.offer
    sku       = var.vm_config.os_image.sku
    version   = var.vm_config.os_image.version
  }
}