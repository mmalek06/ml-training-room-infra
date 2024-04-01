resource "azurerm_storage_account_network_rules" "mtr_sa_network_rules" {
  storage_account_id   = var.storage_account_id
  default_action             = "Deny"
  ip_rules                   = ["127.0.0.1", "87.205.30.9"]
  bypass                     = ["AzureServices", "Metrics"]

  depends_on = [ var.network_rules_dependencies ]
}