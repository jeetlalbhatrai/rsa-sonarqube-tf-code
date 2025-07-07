output "bastion_public_ip" {
  value = azurerm_public_ip.bastion_ip.ip_address
}

output "function_app_url" {
  value = azurerm_function_app.hello_func.default_hostname
}
