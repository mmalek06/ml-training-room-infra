resource "azurerm_storage_blob" "mtr_hello_function_blob" {
  name                   = "MTR.ListBlobsFunction.publish.zip"
  storage_account_name   = azurerm_storage_account.mtr_storage.name
  storage_container_name = azurerm_storage_container.mtr_hello_function_container.name
  type                   = "Block"
  source                 = "./example_code/MTR.ListBlobsFunction/MTR.ListBlobsFunction.publish.zip"

  depends_on = [ null_resource.run_pre_hello_powershell_script ]
}