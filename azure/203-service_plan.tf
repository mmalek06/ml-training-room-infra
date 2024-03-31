resource "azurerm_service_plan" "mtr_functions_svc_plan" {
  name                = "mtr-functions-svc-plan"
  location            = azurerm_resource_group.mtr_rg.location
  resource_group_name = azurerm_resource_group.mtr_rg.name
  os_type             = "Linux"
  sku_name            = "B1"

  tags = {
    environment = "local"
  }
}