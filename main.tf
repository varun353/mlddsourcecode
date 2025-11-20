resource "azurerm_resource_group" "mldreamdecor" {
  for_each = var.rg
  name     = each.value.rg_name
  location = each.value.location
}