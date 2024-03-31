resource "azurerm_resource_group" "mtr_rg" {
  name     = "mtr-resources"
  location = "France Central"

  tags = {
    environment = "${var.environment_name}"
  }
}