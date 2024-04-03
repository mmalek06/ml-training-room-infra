resource "azurerm_resource_group" "mltr_rg" {
  name     = "mltr-resources"
  location = "Germany West Central"

  tags = {
    environment = "${var.environment_name}"
  }
}