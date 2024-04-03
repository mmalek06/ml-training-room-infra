resource "azurerm_application_insights" "mtr_ai" {
  name                = "mtr-appinsights"
  location            = azurerm_resource_group.mtr_rg.location
  resource_group_name = azurerm_resource_group.mtr_rg.name
  workspace_id        = azurerm_log_analytics_workspace.mtr_ai_workspace.id
  application_type    = "web"

  tags = {
    environment = "${var.environment_name}"
  }
}