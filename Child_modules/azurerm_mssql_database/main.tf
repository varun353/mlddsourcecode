resource "azurerm_mssql_database" "database" {

  for_each  = var.sql_database
  name      = each.value.sql_database_name
  server_id = data.azurerm_mssql_server.sqlserver[each.key].id

  license_type = each.value.license_type
  max_size_gb  = each.value.max_size_gb
  sku_name     = each.value.sku_name

  #   # prevent the possibility of accidental data loss
  #   lifecycle {
  #     prevent_destroy = true
  #   }
}