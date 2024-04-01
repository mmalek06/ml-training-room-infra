resource "azurerm_storage_container" "mtr_hello_function_container" {
  name                  = "hello-function-releases"
  storage_account_name  = var.storage_account_name
  container_access_type = "private"
}