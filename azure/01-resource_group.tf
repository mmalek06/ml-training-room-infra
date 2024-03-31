resource "azurerm_resource_group" "mtr_rg" {
  name     = "mtr-resources"
  location = "Poland Central"

  tags = {
    environment = "${var.environment_name}"
  }
}