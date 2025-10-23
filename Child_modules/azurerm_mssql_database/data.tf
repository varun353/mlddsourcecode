data "azurerm_mssql_server" "sqlserver" {
  for_each            = var.sql_database
  name                = each.value.sql_server_name
  resource_group_name = each.value.resource_group_name
}

# output "id" {
#   value = data.azurerm_mssql_server.sqlserver.id
# }

# or

output "azurerm_mssql_server" { # in output block "azurerm_mssql_server" could be anyting, this is just a name
  value = {
    for k, v in data.azurerm_mssql_server.sqlserver :
    k => v.id
  }
}