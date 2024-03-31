resource "azurerm_virtual_network" "mtr_vnet" {
  name                = "mtr-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.mtr_rg.location
  resource_group_name = azurerm_resource_group.mtr_rg.name
}
