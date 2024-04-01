output "storage_account_name" {
  value = azurerm_storage_account.mtr_storage.name
}

output "storage_account_id" {
  value = azurerm_storage_account.mtr_storage.id
}

output "storage_account_primary_connection_string" {
  value = azurerm_storage_account.mtr_storage.primary_connection_string
}

output "storage_account_primary_access_key" {
  value = azurerm_storage_account.mtr_storage.primary_access_key
}

output "resource_group_location" {
  value = azurerm_resource_group.mtr_rg.location
}

output "resource_group_name" {
  value = azurerm_resource_group.mtr_rg.name
}

output "subnet_id" {
  value = azurerm_subnet.mtr_subnet.id
}
