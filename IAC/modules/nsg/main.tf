############################################
# modules/nsg/main.tf
############################################
resource "azurerm_network_security_group" "this" {
  for_each            = var.nsgs
  name                = "${each.key}-nsg"
  location            = var.location
  resource_group_name = var.rg_name

  # one dynamic block per inbound rule the caller supplied
  dynamic "security_rule" {
    for_each = each.value.inbound_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction      # "Inbound"
      access                     = security_rule.value.access         # "Allow"/"Deny"
      protocol                   = security_rule.value.protocol       # "Tcp", "*", …
      source_address_prefixes    = security_rule.value.source_address_prefixes
      destination_address_prefix = "*"                                # keep simple
      destination_port_ranges    = security_rule.value.destination_port_ranges
      source_port_range          = "*"
    }
  }
}

output "ids" {
  value = { for k, n in azurerm_network_security_group.this : k => n.id }
}
