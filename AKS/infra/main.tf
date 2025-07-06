module "resource_group" {
  source                  = "../modules/resource_group"
  resource_group_name     = "rsa-aks"
  resource_group_location = "East US"
}

module "aks" {
  depends_on            = [module.resource_group]
  source                = "../modules/aks"
  cluster_name          = "rsa-aks-cluster"
  location              = "East US"
  resource_group_name   = "rsa-aks"
  default_node_pool_name = "default"
  default_node_count    = 1
  default_node_pool_vm_size = "Standard_D2s_v3"
  dns_prefix            = "rsaaksdns"
}

# module "sql_server" {
#   depends_on                   = [module.key_vault]
#   source                       = "../modules/azurerm_sql_server"
#   sql_server_name              = "rsa-sql-server"
#   resource_group_name          = "rsa-aks"
#   resource_group_location      = "East US"
#   sql_server_version           = "12.0"
#   key_vault_name            = "rsa-keyvault"
#   secretname = {
#     db_username = {
#       name  = "db-username"
#       value = "dbadmin"
#     }
#     db_password = {
#       name  = "vm-password"
#       value = "P@ssw0rd1234!"
#     }
#   } 
# }

# module "sql_database" {
#   depends_on    = [module.sql_server,module.key_vault]
#   source        = "../modules/azurerm_sql_database"
#   database_name = "todoappdb-jeet"
#   collation     = "SQL_Latin1_General_CP1_CI_AS"
#   license_type  = "LicenseIncluded"
#   max_size_gb   = 2
#   sku_name      = "GP_S_Gen5_2"
#   sql_server_name = "todoapp-sql-server-jeet"
#   resource_group_name = "rsa-aks"
# }

# module "key_vault" {
#   depends_on              = [module.resource_group]
#   source                  = "../modules/azure_key_vault"
#   key_vault_name          = "rsa-keyvault"
#   resource_group_name     = "rsa-aks"
#   resource_group_location = "centralindia"
#   tenant_id               = "ec303232-515f-4ef2-a3d5-df83712a9eb0"
#   soft_delete_retention_days = 7
#   key_vault_secrets = {
#     db_username = {
#       name  = "db-username"
#       value = "dbadmin"
#     },
#     db_password = {
#       name  = "db-password"
#       value = "dbpass@123"
#     }
#   }
# }



# module "node_pool" {
#   source                = "../modules/node_pool"
#   depends_on            = [module.aks, module.resource_group]
#   cluster_name = module.aks.cluster_name 
#   kubernetes_cluster_id = module.aks.cluster_id
#   rg_name = "rsa-aks"
#   node_pools = {
#     "frontend" = { vm_size = "Standard_D2s_v3", node_count = 1, mode = "User" }
#   }
# }
