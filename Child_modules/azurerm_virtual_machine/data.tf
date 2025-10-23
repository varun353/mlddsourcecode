data "azurerm_subnet" "subnet" {
  for_each             = var.virtual_machine
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "pip" {
  for_each            = var.virtual_machine
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault_secret" "secret_username" {
  for_each     = var.virtual_machine
  name         = each.value.secret_username
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}
data "azurerm_key_vault_secret" "secret_password" {
  for_each     = var.virtual_machine
  name         = each.value.secret_password
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}
data "azurerm_key_vault" "kv" {
  for_each            = var.virtual_machine
  name                = each.value.kv_name
  resource_group_name = each.value.resource_group_name
}








# output "azurerm_subnet" {
#   value = {
#     for k, v in data.azurerm_subnet.subnet :
#     k => v.id
#   }
# }