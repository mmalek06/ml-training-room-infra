resource "azurerm_service_plan" "mtr_hello_function_svc_plan" {
  name                = "mtr-hello-function-svc-plan"
  location            = azurerm_resource_group.mtr_rg.location
  resource_group_name = azurerm_resource_group.mtr_rg.name
  os_type             = "Linux"
  sku_name            = "Y1"
  # sku_name            = "B1" # this doesn't work with zip package download for some reason - consumption tier needs to be used

  tags = {
    environment = "${var.environment_name}"
  }
}