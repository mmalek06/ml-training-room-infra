resource "azurerm_storage_container" "mtr_hello_function_container" {
  name                  = "hello-function-releases"
  storage_account_name  = azurerm_storage_account.mtr_storage.name
  container_access_type = "private"

  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
    read   = "10m"
  }
}