resource "azurerm_log_analytics_workspace" "mtr_ai_workspace" {
  name                = "mtr-workspace"
  location            = azurerm_resource_group.mtr_rg.location
  resource_group_name = azurerm_resource_group.mtr_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    environment = "${var.environment_name}"
  }
}