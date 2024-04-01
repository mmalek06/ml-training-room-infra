data "azurerm_storage_account_blob_container_sas" "storage_account_blob_container_sas_for_hello" {
  connection_string = var.storage_account_primary_connection_string
  container_name    = azurerm_storage_container.mtr_hello_function_container.name

  start  = timeadd(timestamp(), "-10m")
  expiry = timeadd(timestamp(), "10m")

  permissions {
    read   = true
    add    = false
    create = false
    write  = false
    delete = false
    list   = true
  }
}

resource "azurerm_linux_function_app" "mtr_hello_function_app" {
  name                       = "mtr-hello-function-app2"
  location                   = var.resource_group_location
  resource_group_name        = var.resource_group_name
  service_plan_id            = azurerm_service_plan.mtr_hello_function_svc_plan.id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_primary_access_key

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"       = "dotnet"
    "WEBSITE_RUN_FROM_PACKAGE" =     "${azurerm_storage_blob.mtr_hello_function_blob.url}${data.azurerm_storage_account_blob_container_sas.storage_account_blob_container_sas_for_hello.sas}"
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
    "AzureWebJobsStorage"            = var.storage_account_primary_connection_string
    "AzureWebJobsDisableHomepage"    = "true"
  }

  site_config {
    always_on = true
    application_insights_connection_string = var.ai_connection_string
    
    application_stack {
      dotnet_version              = "8.0"
      use_dotnet_isolated_runtime = true
    }

    cors {
      allowed_origins = ["*"]
    }
  }

  tags = {
    environment = "${var.environment_name}"
  }
}