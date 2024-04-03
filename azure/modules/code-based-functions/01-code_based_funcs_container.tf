resource "azurerm_storage_container" "mltr_code_based_functions_container" {
  name                  = "mltr-code-functions-container"
  storage_account_name  = var.storage_account_name
  container_access_type = "private"
}