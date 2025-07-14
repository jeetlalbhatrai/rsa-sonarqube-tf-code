rg_name   = "rsa-3tier"
location  = "East US"
vnet_name = "rsa-vnet-3tier"
vnet_cidr = ["192.168.0.0/16"]

subnets = {
  frontend = { address_prefixes = ["192.168.1.0/24"] }
  backend  = { address_prefixes = ["192.168.2.0/24"] }
  db       = { address_prefixes = ["192.168.3.0/24"] }
}

nsgs = {
  frontend = {
    inbound_rules = [
      {
        name                    = "allow_http_https_office"
        priority                = 100
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = ["203.0.113.42/32"] # replace with your IP/CIDR
        destination_port_ranges = ["80", "443"]
      }
    ]
  }

  backend = {
    inbound_rules = [
      {
        name                    = "allow_app_from_frontend"
        priority                = 100
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = ["192.168.1.0/24"]
        destination_port_ranges = ["8080"]
      }
    ]
  }

  db = {
    inbound_rules = [
      {
        name                    = "allow_sql_from_backend"
        priority                = 100
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = ["192.168.2.0/24"]
        destination_port_ranges = ["1433", "5432"]
      }
    ]
  }
}

nat_gateway_name = "rsa-nat-gateway-3tier"