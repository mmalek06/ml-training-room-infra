resource "random_string" "random_storage_account_suffix" {
  length  = 10
  special = false
  upper   = false
  numeric = true
  lower   = true
}


resource "azurerm_storage_account" "mltr_storage" {
  name                     = "mltrstorage${random_string.random_storage_account_suffix.result}"
  resource_group_name      = azurerm_resource_group.mltr_rg.name
  location                 = azurerm_resource_group.mltr_rg.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "${var.environment_name}"
  }
}