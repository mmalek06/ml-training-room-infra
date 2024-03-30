resource "random_string" "random_storage_account_suffix" {
  length  = 10
  special = false
  upper   = false
  numeric = true
  lower   = true
}


resource "azurerm_storage_account" "mtr_storage" {
  name                     = "mtrstorage${random_string.random_storage_account_suffix.result}"
  resource_group_name      = azurerm_resource_group.mtr_rg.name
  location                 = azurerm_resource_group.mtr_rg.location
  account_kind             = "BlobStorage"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.mtr_subnet.id]
    bypass                     = ["AzureServices", "Metrics"]
  }

  tags = {
    environment = "local"
  }
}