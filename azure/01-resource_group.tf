resource "azurerm_resource_group" "mtr_rg" {
  name     = "mtr_resources"
  location = "Poland Central"
  tags = {
    environment = "local"
  }
}