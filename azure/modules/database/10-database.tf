resource "azurerm_postgresql_flexible_server" "mltr_pgsql" {
  name                          = "mltr-pgsql-server"
  location                      = var.resource_group_location
  resource_group_name           = var.resource_group_name
  version                       = "13"
  administrator_login           = "mltradmin"
  administrator_password        = random_password.pg_password.result
  sku_name                      = "B_Standard_B1ms"
  storage_mb                    = data.external.public_ip.result.ip
  backup_retention_days         = 7
  delegated_subnet_id           = null

  tags = {
    environment = "${var.environment_name}"
  }
}

output "postgresql_server_name" {
  value = azurerm_postgresql_flexible_server.mltr_pgsql.name
}

output "postgresql_server_admin_login" {
  value = azurerm_postgresql_flexible_server.mltr_pgsql.administrator_login
}
