resource "azurerm_linux_function_app" "mtr_hello_function" {
  name                       = "mtr-hello-function"
  location                   = azurerm_resource_group.mtr_rg.location
  resource_group_name        = azurerm_resource_group.mtr_rg.name
  service_plan_id            = azurerm_service_plan.mtr_functions_svc_plan.id
  storage_account_name       = azurerm_storage_account.mtr_storage.name
  storage_account_access_key = azurerm_storage_account.mtr_storage.primary_access_key

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet"
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "AzureWebJobsStorage"      = azurerm_storage_account.mtr_storage.primary_connection_string
  }

  site_config {
    application_insights_connection_string = azurerm_application_insights.mtr_ai.connection_string
    application_insights_key               = azurerm_application_insights.mtr_ai.instrumentation_key

    application_stack {
      dotnet_version              = "8.0"
      use_dotnet_isolated_runtime = true
    }

    cors {
      allowed_origins = ["*"]
    }
  }

  tags = {
    environment = "local"
  }
}