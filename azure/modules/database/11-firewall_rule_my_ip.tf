resource "azurerm_postgresql_flexible_server_firewall_rule" "mltr_allow_my_ip_to_pgsql" {
  name             = "mltr-allow-my-ip"
  server_id        = azurerm_postgresql_flexible_server.mltr_pgsql.id
  start_ip_address = data.external.public_ip.result.ip
  end_ip_address   = data.external.public_ip.result.ip
}
