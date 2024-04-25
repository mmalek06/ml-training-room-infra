resource "azurerm_postgresql_flexible_server_firewall_rule" "azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_postgresql_flexible_server.mltr_pgsql.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
