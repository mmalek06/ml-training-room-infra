data "azurerm_storage_account_blob_container_sas" "storage_account_blob_container_sas_for_hello" {
  connection_string = azurerm_storage_account.mtr_storage.primary_connection_string
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

resource "azurerm_linux_function_app" "mtr_hello_function" {
  name                       = "mtr-hello-function7"
  location                   = azurerm_resource_group.mtr_rg.location
  resource_group_name        = azurerm_resource_group.mtr_rg.name
  service_plan_id            = azurerm_service_plan.mtr_hello_function_svc_plan.id
  storage_account_name       = azurerm_storage_account.mtr_storage.name
  storage_account_access_key = azurerm_storage_account.mtr_storage.primary_access_key

  depends_on = [azurerm_resource_group.mtr_rg, azurerm_service_plan.mtr_hello_function_svc_plan, azurerm_storage_account.mtr_storage]

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"    = "dotnet"
    "WEBSITE_RUN_FROM_PACKAGE"    = "https://${azurerm_storage_account.mtr_storage.name}.blob.core.windows.net/${azurerm_storage_container.mtr_hello_function_container.name}/${azurerm_storage_blob.mtr_hello_function_blob.name}${data.azurerm_storage_account_blob_container_sas.storage_account_blob_container_sas_for_hello.sas}"
    "AzureWebJobsStorage"         = azurerm_storage_account.mtr_storage.primary_connection_string
    "AzureWebJobsDisableHomepage" = "true"
  }

  site_config {
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