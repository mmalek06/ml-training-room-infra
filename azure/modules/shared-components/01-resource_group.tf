resource "azurerm_resource_group" "mtr_rg" {
  name     = "mtr-resources"
  location = "Germany West Central"

  tags = {
    environment = "${var.environment_name}"
  }
}