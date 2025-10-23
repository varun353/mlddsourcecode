resource "azurerm_key_vault" "kv" {
  for_each                    = var.kv
  name                        = each.value.kv_name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled
  enable_rbac_authorization   = each.value.enable_rbac_authorization # using rbac instead access policy
  sku_name                    = each.value.sku_name

  #   access_policy {
  #     tenant_id = data.azurerm_client_config.current.tenant_id
  #     object_id = data.azurerm_client_config.current.object_id

  #     key_permissions = ["Get",]

  #     secret_permissions = ["Get", "Set"]

  #     storage_permissions = ["Get",]
  #   }
}



# resource "azurerm_role_assignment" "example" {
#     for_each = var.kv
#   scope                = each.value.scope
#   role_definition_name = each.value.role_definition_name
#   principal_id         = each.value.principal_id
# }