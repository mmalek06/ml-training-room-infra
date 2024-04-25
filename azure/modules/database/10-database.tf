resource "azurerm_postgresql_flexible_server" "mltr_db" {
  name                          = "mltr-pgsql-db"
  location                      = var.resource_group_location
  resource_group_name           = var.resource_group_name
  version                       = "13"
  administrator_login           = "mltradmin"
  administrator_password        = var.pg_password
  sku_name                      = "B_Standard_B1ms"
  storage_mb                    = 32768
  backup_retention_days         = 7
  delegated_subnet_id           = null

  tags = {
    environment = "${var.environment_name}"
  }
}
