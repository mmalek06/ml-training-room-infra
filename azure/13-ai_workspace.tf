resource "azurerm_log_analytics_workspace" "mtr_ai_workspace" {
  name                = "mtr-workspace"
  location            = azurerm_resource_group.mtr_rg.location
  resource_group_name = azurerm_resource_group.mtr_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    environment = "${var.environment_name}"
  }

  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
    read   = "10m"
  }
}
