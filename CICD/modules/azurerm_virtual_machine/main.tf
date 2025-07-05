resource "azurerm_network_interface" "main" {
  name                = var.network_nic_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.rsa-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.rsa_public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = data.azurerm_network_security_group.existing_nsg.id
}


resource "azurerm_linux_virtual_machine" "example" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = var.vm_size
  admin_username      = data.azurerm_key_vault_secret.secretname["vm_username"].value
  admin_password        = data.azurerm_key_vault_secret.secretname["vm_password"].value
  custom_data = var.custom_data

  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
    version   = var.os_version
  }
}