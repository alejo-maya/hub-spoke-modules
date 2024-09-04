resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.bastion_config.resource_group_name
  virtual_network_name = var.bastion_config.vnet_name
  address_prefixes     = var.bastion_config.address_prefixes
}

module "public_ip" {
  source = "../public_ip"

  public_ip_config = {
    name                = "${var.bastion_config.bastion_name}-public-ip0"
    resource_group_name = var.bastion_config.resource_group_name
    location            = var.bastion_config.location
  }
}

resource "azurerm_bastion_host" "bastion" {
  name                = var.bastion_config.bastion_name
  resource_group_name = var.bastion_config.resource_group_name
  location            = var.bastion_config.location

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = module.public_ip.public_ip_id
  }
}
