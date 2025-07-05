module "resource_group" {
  source                  = "../modules/resource_group"
  resource_group_name     = var.rg_name
  resource_group_location = var.location
}

module "vnet" {
  source              = "../modules/vnet"
  depends_on          = [module.resource_group]
  vnet_name           = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.vnet_cidr
}

module "subnet" {
  source     = "../modules/subnet"
  depends_on = [module.vnet, module.resource_group]
  rg_name    = var.rg_name
  vnet_name  = module.vnet.name
  subnets    = var.subnets
}


module "nsg" {
  source     = "../modules/nsg"
  depends_on = [module.resource_group, module.vnet, module.subnet]
  rg_name    = var.rg_name
  location   = var.location
  nsgs       = var.nsgs
}

module "nsg_assoc" {
  source     = "../modules/nsg_assoc"
  depends_on = [module.resource_group, module.vnet, module.subnet, module.nsg]
  for_each   = var.subnets # create one attachment per subnet
  subnet_id  = module.subnet.ids[each.key]
  nsg_id     = module.nsg.ids[each.key]
}

module "frontend_nat_gateway" {
  source              = "../modules/nat_gateway"
  depends_on = [module.resource_group, module.vnet, module.subnet, module.nsg,module.nsg_assoc]
  name                = var.nat_gateway_name
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = module.subnet.ids["frontend"]
}