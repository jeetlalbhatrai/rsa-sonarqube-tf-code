module "resource_group" {
  source                  = "../modules/resource_group"
  resource_group_name     = "rsa-aks"
  resource_group_location = "East US"
}

module "vnet" {
  source              = "../modules/vnet"
  depends_on            = [module.resource_group]
  vnet_name           = "rsa-aks-vnet"
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  address_space       = ["192.168.0.0/16"]
}

module "subnet" {
  source              = "../modules/subnet"
  depends_on            = [module.resource_group, module.vnet]
  vnet_name           = module.vnet.vnet_name
  resource_group_name = module.resource_group.resource_group_name
  subnets = {
    private = { name = "private-subnet", address_prefix = "192.168.1.0/24" }
  }
}

module "aks" {
  depends_on            = [module.resource_group,module.vnet, module.subnet]
  source                = "../modules/aks"
  cluster_name          = "rsa-aks-cluster"
  location              = module.resource_group.resource_group_location
  resource_group_name   = module.resource_group.resource_group_name
  default_node_pool_name = "frontend"
  default_node_count    = 1
  default_node_pool_vm_size = "Standard_D2s_v3"
  dns_prefix            = "rsaaksdns"
  vnet_subnet_id        = module.subnet.subnet_ids["private"]

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
#   key_vault_name          = "rsa-keyvault-test34"
#   resource_group_name     = module.resource_group.resource_group_name
#   resource_group_location = module.resource_group.resource_group_location
#   # tenant_id               = "a17cb07c-9570-4b4a-a878-951e4ce8b011"
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



module "node_pool" {
  source                = "../modules/node_pool"
  depends_on            = [module.aks, module.resource_group, module.vnet, module.subnet]
  cluster_name = module.aks.cluster_name 
  kubernetes_cluster_id = module.aks.cluster_id
  rg_name = module.resource_group.resource_group_name
  node_pools = {
    "backend" = { vm_size = "Standard_D2s_v3", node_count = 1, mode = "User", subnet_id = module.subnet.subnet_ids["private"]  }
  }
}

