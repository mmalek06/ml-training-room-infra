output "storage_account_name" {
  value = azurerm_storage_account.mltr_storage.name
}

output "storage_account_primary_connection_string" {
  value = azurerm_storage_account.mltr_storage.primary_connection_string
}

output "storage_account_primary_access_key" {
  value = azurerm_storage_account.mltr_storage.primary_access_key
}

output "resource_group_location" {
  value = azurerm_resource_group.mltr_rg.location
}

output "resource_group_name" {
  value = azurerm_resource_group.mltr_rg.name
}

output "ai_connection_string" {
  value = azurerm_application_insights.mltr_ai.connection_string
}
