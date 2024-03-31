resource "azurerm_resource_group" "mtr_rg" {
  name     = "mtr-resources"
  location = "UK South"

  tags = {
    environment = "${var.environment_name}"
  }
}