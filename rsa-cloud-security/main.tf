resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# Create VNet
resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

# Subnet for Bastion
resource "azurerm_subnet" "bastion" {
  name                 = "${var.prefix}-bastion-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

# NSG for Bastion
resource "azurerm_network_security_group" "bastion_nsg" {
  name                = "${var.prefix}-bastion-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate NSG with subnet
resource "azurerm_subnet_network_security_group_association" "bastion_assoc" {
  subnet_id                 = azurerm_subnet.bastion.id
  network_security_group_id = azurerm_network_security_group.bastion_nsg.id
}

# Public IP for Bastion
resource "azurerm_public_ip" "bastion_ip" {
  name                = "${var.prefix}-bastion-ip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Network Interface
resource "azurerm_network_interface" "bastion_nic" {
  name                = "${var.prefix}-bastion-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.bastion.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_ip.id
  }
}

# Bastion VM (Jump Server)
resource "azurerm_linux_virtual_machine" "bastion" {
  name                = "${var.prefix}-bastion-vm"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_B1s"
  admin_username      = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.bastion_nic.id
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")  # Adjust path if needed
    #public_key = file("${path.module}/id_rsa.pub")

  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

# Storage Account for Function App
resource "azurerm_storage_account" "function_storage" {
  name                     = "${var.prefix}funcstorage"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# App Service Plan
resource "azurerm_app_service_plan" "function_plan" {
  name                = "${var.prefix}-func-plan"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
#   kind                = "FunctionApp"
 kind                = "Linux"
  reserved            = true

#   sku {
#     tier = "Dynamic"
#     size = "Y1"
#   }
sku {
    tier = "Basic"
    size = "B1"
  }
}

# Function App
resource "azurerm_function_app" "hello_func" {
  name                       = "${var.prefix}-func"
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  app_service_plan_id        = azurerm_app_service_plan.function_plan.id
  storage_account_name       = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key
  version                    = "~3"

#   site_config {
#     application_stack {
#       node_version = "16"
#     }
#   }
site_config {
  linux_fx_version = "Node|16"
}


#   app_settings = {
#     "FUNCTIONS_WORKER_RUNTIME" = "node"
#     "WEBSITE_RUN_FROM_PACKAGE" = "1"
#   }
app_settings = {
  "FUNCTIONS_WORKER_RUNTIME" = "node"
  "WEBSITE_RUN_FROM_PACKAGE" = "1"
}

}
