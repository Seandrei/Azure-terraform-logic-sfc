variable "rg_name" {
  default = "CIC_PH_Azure_Capability_Build"
}

variable "region_name"{
    default = "centralus"
}




##---------------------------------------VIRTUAL NETWORK ------------------------------------------------##
variable "vn_name"{
    default = "Asseth-a-thon-VN"
}

variable "vn_address_space"{
    default = ["10.0.0.0/16"]
}

##--------------------------------------- SUBNET  ------------------------------------------------##

variable "subnet_name"{
    default ="Asseth-a-thon-Subnet"
}

variable "subnet_address_prefixes"{
    default =["10.0.2.0/24"]
}

##--------------------------------------- PUBLIC IP  ------------------------------------------------##

variable "public_ip_name"{
    default = "Asseth-a-thon-PublicIP"
}

variable "public_ip_allocation_method"{
    default = "Dynamic"
}
##--------------------------------------- Security Group  ------------------------------------------------##

variable "security_group_name"{
    default = "Asseth-a-thon-NSG"
}


##-------------------security rule----------------#
variable "security_rule_name"{
    default ="SSH"
}

variable "security_rule_priority"{
    default = 1001
}

variable "security_rule_direction"{
    default = "Inbound"
}

variable "security_rule_access"{
    default = "Allow"
}

variable "security_rule_protocol"{
    default = "Tcp"
}

variable "security_rule_source_port_range"{
    default = "*"
}

variable "security_rule_destination_port_range"{
    default = "22"
}

variable "security_rule_source_address_prefix"{
    default = "*"
}

variable "security_rule_destination_address_prefix"{
    default = "*"
}

##--------------------------------------- NETWORK INTERFACE  ------------------------------------------------##

variable "network_interface_name"{
    default ="Asseth-a-thon-NI"
}

##-----------ip configuration-----------##

variable "ip_configuration_name"{
    default ="Asseth-a-thon--IPConfiguration"
}

variable "ip_configuration_private_ip_address_allocation"{
    default ="Dynamic"
}

##--------------------------------------- SSH KEY  ------------------------------------------------##

variable "ssh_key_algorithm"{
    default ="RSA"
}

variable "ssh_key_rsa_bits"{
    default = 4096
}
##--------------------------------------- VIRTUAL MACHINE (LINUX)  ------------------------------------------------##

variable "vm_name"{
  default = "Asseth-a-thon-Linux-Instance"
}

variable "vm_size"{
    default ="Standard_F2"
}


##-------source image reference--------##

variable "sri_publisher"{
    default ="Canonical"
}

variable "sri_offer"{
    default ="UbuntuServer"
}

variable "sri_sku"{
    default ="16.04-LTS"
}

variable "sri_version"{
    default ="latest"
}

##-------computer details------##

variable "computer_name"{
    default ="Asseth-a-thon-Computer"
}

variable "admin_username"{
    default ="Assethathonadmin"
}

variable "disable_pass_auth"{
    default = true
}

##-------admin ssh key------##

variable "admin_ssh_key_username"{
    default ="Assethathonadmin"
}

##-------os_disk------##

variable "os_disk_caching"{
    default ="ReadWrite"
}

variable "os_disk_storage_account_type"{
    default ="Standard_LRS"
}

##-------storage_account------##

variable "storage_account_name" {
    default = "Azure_Asset_Storage"
}

variable "container_name" {
    default = "tfstatefile"
}

variable "key" {
    default = "terraform.tfstate"
}
