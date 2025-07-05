variable "rg_name" {
  description = "Resource‑group name where the NSGs will live"
  type        = string
}

variable "location" {
  description = "Azure region (e.g. eastus, westeurope)"
  type        = string
}

variable "nsgs" {
  description = <<EOF
Map keyed by subnet tier (frontend / backend / db …).
Each entry contains a list of inbound rules; every rule is an object
with exactly the fields the provider expects.
EOF

  type = map(object({
    inbound_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string   # "Inbound" or "Outbound"
      access                     = string   # "Allow" or "Deny"
      protocol                   = string   # "Tcp", "Udp", "*"
      source_address_prefixes    = list(string)
      destination_port_ranges    = list(string)
    }))
  }))
}
