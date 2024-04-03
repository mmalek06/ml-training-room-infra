resource "azurerm_application_insights" "mltr_ai" {
  name                = "mltr-appinsights"
  location            = azurerm_resource_group.mltr_rg.location
  resource_group_name = azurerm_resource_group.mltr_rg.name
  workspace_id        = azurerm_log_analytics_workspace.mltr_ai_workspace.id
  application_type    = "web"

  tags = {
    environment = "${var.environment_name}"
  }
}