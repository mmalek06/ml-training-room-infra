resource "azurerm_service_plan" "mtr_hello_function_svc_plan" {
  name                = "mtr-hello-function-svc-plan"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "B1"
  # sku_name            = "B1" # this doesn't work with zip package download for some reason - consumption tier needs to be used

  tags = {
    environment = "${var.environment_name}"
  }
}