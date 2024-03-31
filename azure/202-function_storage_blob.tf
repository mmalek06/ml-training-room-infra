resource "azurerm_storage_blob" "example_function" {
  name                   = "MTR.ListBlobsFunction.publish.zip"
  storage_account_name   = azurerm_storage_account.mtr_storage.name
  storage_container_name = azurerm_storage_container.mtr_functions_container.name
  type                   = "Block"
  source                 = "./example_code/MTR.ListBlobsFunction/MTR.ListBlobsFunction.publish.zip"
}