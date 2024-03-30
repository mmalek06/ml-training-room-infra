resource "azurerm_subnet" "mtr_subnet" {
  name                 = "mtr_subnet"
  resource_group_name  = azurerm_resource_group.mtr_rg.name
  virtual_network_name = azurerm_virtual_network.mtr_vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  service_endpoints = ["Microsoft.Storage"]
}
