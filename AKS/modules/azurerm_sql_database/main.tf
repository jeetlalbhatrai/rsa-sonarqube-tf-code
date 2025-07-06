resource "azurerm_mssql_database" "example" {
  name         = var.database_name
  server_id    = data.azurerm_mssql_server.example.id
  collation    = var.collation
  license_type = var.license_type
  max_size_gb  = var.max_size_gb
  sku_name     = var.sku_name
}


