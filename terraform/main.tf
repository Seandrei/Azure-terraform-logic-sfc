# provider "azurerm" {
#   features {}
# }

terraform {
  backend "azurerm" {
    resource_group_name = var.rg_name
    storage_account_name = var.storage_account_name
    container_name = var.container_name
    key = var.key
  }
}



##---------------------------------------VIRTUAL NETWORK ------------------------------------------------##
resource "azurerm_virtual_network" "Example-VirtualNet" {
  name                = var.vn_name
  address_space       = var.vn_address_space
  location            = var.region_name
  resource_group_name = var.rg_name
}


##--------------------------------------- SUBNET  ------------------------------------------------##
resource "azurerm_subnet" "Example-Subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.Example-VirtualNet.name
  address_prefixes     = var.subnet_address_prefixes
}

##--------------------------------------- PUBLIC IP  ------------------------------------------------##

resource "azurerm_public_ip" "Example-PublicIP" {
  name                = var.public_ip_name
  location            = var.region_name
  resource_group_name = var.rg_name
  allocation_method   = var.public_ip_allocation_method
}



##--------------------------------------- Network Security Group  ------------------------------------------------##


resource "azurerm_network_security_group" "Example-NSG" {
  name                = var.security_group_name
  location            = var.region_name
  resource_group_name = var.rg_name

  security_rule {
    name                       = var.security_rule_name
    priority                   = var.security_rule_priority
    direction                  = var.security_rule_direction
    access                     = var.security_rule_access
    protocol                   = var.security_rule_protocol
    source_port_range          = var.security_rule_source_port_range
    destination_port_range     = var.security_rule_destination_port_range
    source_address_prefix      = var.security_rule_source_address_prefix
    destination_address_prefix = var.security_rule_destination_address_prefix
  }
}

##--------------------------------------- NETWORK INTERFACE  ------------------------------------------------##
resource "azurerm_network_interface" "Example-NI" {
  name                = var.network_interface_name
  location            = var.region_name
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = azurerm_subnet.Example-Subnet.id
    private_ip_address_allocation = var.ip_configuration_private_ip_address_allocation
     public_ip_address_id          = azurerm_public_ip.Example-PublicIP.id
  }
}



##--------------------------------------- CONNECTING THE SG TO THE NIC  ------------------------------------------------##

resource "azurerm_network_interface_security_group_association" "Example-NI-NSG" {
  network_interface_id     = azurerm_network_interface.Example-NI.id
  network_security_group_id = azurerm_network_security_group.Example-NSG.id
}


##--------------------------------------- SSH KEY  ------------------------------------------------##
resource "tls_private_key" "Example-Key" {
    algorithm = var.ssh_key_algorithm
    rsa_bits = var.ssh_key_rsa_bits
}

##--------------------------------------- VIRTUAL MACHINE (LINUX)  ------------------------------------------------##
resource "azurerm_linux_virtual_machine" "Example-VM"{
  name                  = var.vm_name
  location              = var.region_name
  resource_group_name   = var.rg_name
  size                  = var.vm_size
  network_interface_ids =  [azurerm_network_interface.Example-NI.id]
  


source_image_reference {
    publisher = var.sri_publisher
    offer     = var.sri_offer
    sku       = var.sri_sku
    version   = var.sri_version
  }

##-------computer details------##
  computer_name                   = var.computer_name
  admin_username                  = var.admin_username
  disable_password_authentication = var.disable_pass_auth


  admin_ssh_key {
    username   = var.admin_ssh_key_username
    public_key =  tls_private_key.Example-Key.public_key_openssh
  }


  os_disk {
      caching = var.os_disk_caching
      storage_account_type = var.os_disk_storage_account_type

  }


}