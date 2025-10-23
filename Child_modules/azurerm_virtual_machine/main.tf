
resource "azurerm_network_interface" "nic" {
  for_each            = var.virtual_machine
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.ipconfig_name
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id #
    private_ip_address_allocation = each.value.private_ip_address_allocation
    public_ip_address_id          = data.azurerm_public_ip.pip[each.key].id # 
  }
}

resource "azurerm_linux_virtual_machine" "server" {
  depends_on                      = [azurerm_network_interface.nic]
  for_each                        = var.virtual_machine
  name                            = each.value.vm_name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = data.azurerm_key_vault_secret.secret_username[each.key].value
  admin_password                  = data.azurerm_key_vault_secret.secret_password[each.key].value
  disable_password_authentication = each.value.disable_password_authentication
  # need to check this below command by putting it into the tfvars file  
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]



  os_disk {
    caching              = each.value.caching
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
  custom_data = filebase64("${path.module}/install-nginx.sh")
}
