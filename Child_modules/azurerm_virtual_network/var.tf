variable "virtual_network" {
  type = map(object({
    vnet_name           = string
    location            = string
    resource_group_name = string
    address_space       = list(any)
  }))
  description = "Map of virtual networks with details like name, location, and resource group"
}