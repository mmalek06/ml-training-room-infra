resource "azurerm_service_plan" "mltr_code_based_functions_svc_plan" {
  name                = "mltr-code-functions-svc-plan"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "Y1"

  tags = {
    environment = "${var.environment_name}"
  }
}