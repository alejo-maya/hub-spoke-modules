variable "vm_config" {
  description = "Configuration for the virtual machine and its associated resources."
  type = object({
    location            = string
    resource_group_name = string
    subnet_id           = string
    vm_name             = string
    admin_credentials = object({
      username = string
      password = string
    })
    vm_size      = string
    os_disk_name = string
    os_image = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  })
}