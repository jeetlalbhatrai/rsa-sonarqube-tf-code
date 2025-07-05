module "resource_group" {
  source                  = "../modules/azurerm_resource_group"
  resource_group_name     = "rsa-rg"
  resource_group_location = "centralindia"
}

module "vnet" {
  depends_on              = [module.resource_group]
  source                  = "../modules/azurerm_virtual_network"
  azurerm_virtual_network = "rsa-vnet"
  resource_group_location = "centralindia"
  resource_group_name     = "rsa-rg"
  address_space           = ["10.0.0.0/16"]
}

module "rsa_subnet" {
  depends_on           = [module.vnet]
  source               = "../modules/azurerm_subnet"
  subnet_name          = "rsa-subnet"
  resource_group_name  = "rsa-rg"
  virtual_network_name = "rsa-vnet"
  address_prefixes     = ["10.0.1.0/24"]
}

module "public_ip_name" {
  depends_on              = [module.resource_group]
  source                  = "../modules/azurerm_public_ip"
  public_ip_name          = "rsa-public-ip"
  resource_group_name     = "rsa-rg"
  resource_group_location = "centralindia"
  allocation_method       = "Static"
}

module "rsa_vm" {
  depends_on              = [module.rsa_subnet, module.public_ip_name, module.key_vault, module.key_vault_secrets, module.nsg]
  source                  = "../modules/azurerm_virtual_machine"
  vm_name                 = "rsa-vm"
  resource_group_name     = "rsa-rg"
  resource_group_location = "centralindia"
  vm_size                 = "Standard_D2s_v4"
  os_publisher            = "Canonical"
  os_offer                = "0001-com-ubuntu-server-jammy"
  os_sku                  = "22_04-lts"
  os_version              = "latest"
  network_nic_name        = "rsa-nic"
  rsa_subnet_name    = "rsa-subnet"
  virtual_network_name    = "rsa-vnet"
  public_ip_address_name = "rsa-public-ip"
  key_vault_name = "rsa-keyvault-jeet"
  nsg_name = "rsa-vm-nsg"
  secretname = {
    vm_username = "vm-username"
    vm_password = "vm-password"
  }
  custom_data          = base64encode(<<-EOF
    #!/bin/bash

    # Update & install required packages
    apt-get update -y
    apt-get install -y docker.io unzip curl apt-transport-https ca-certificates software-properties-common gnupg

    # Enable Docker
    systemctl enable docker
    systemctl start docker

    # Add user to Docker group
    usermod -aG docker azureuser

    # Pull & run SonarQube container
    docker run -d --name sonarqube -p 9000:9000 sonarqube:lts
  EOF
  )
}

module "key_vault" {
  depends_on              = [module.resource_group]
  source                  = "../modules/azure_key_vault"
  key_vault_name          = "rsa-keyvault-jeet"
  resource_group_name     = "rsa-rg"
  resource_group_location = "centralindia"
  soft_delete_retention_days = 7
  # key_vault_secrets = {
  #   vm_password = {
  #     name  = "vm-password"
  #     value = "rsa@123"
  #   },
  #   vm_username = {
  #     name  = "vm-username"
  #     value = "rsaadmin"
  #   }
  # }
}

module "key_vault_secrets" {
  depends_on              = [module.key_vault]
  source                  = "../modules/azure_key_vault_secret"
  key_vault_name          = "rsa-keyvault-jeet"
  resource_group_name     = "rsa-rg"
  # resource_group_location = "centralindia"
  key_vault_secrets = {
    vm_password = {
      name  = "vm-password"
      value = "rsa@123"
    },
    vm_username = {
      name  = "vm-username"
      value = "rsaadmin"
    }
  }
}


module "nsg" {
  source        = "../modules/azurerm_nsg"
  nsg_name      = "rsa-vm-nsg"
  resource_group_location      = "centralindia"
  resource_group_name       = "rsa-rg"
  security_rules = [
    {
      name                       = "ssh-22"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "sonarqube-9000"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "9000"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}
