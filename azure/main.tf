terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.97.1"
    }
  }
}

provider "azurerm" {
  features {}
}

module "shared_components" {
  source           = "./modules/shared-components"
  environment_name = var.environment_name
}

module "functions" {
  source                                    = "./modules/functions"
  environment_name                          = var.environment_name
  storage_account_name                      = module.shared_components.storage_account_name
  storage_account_primary_connection_string = module.shared_components.storage_account_primary_connection_string
  storage_account_primary_access_key        = module.shared_components.storage_account_primary_access_key
  resource_group_location                   = module.shared_components.resource_group_location
  resource_group_name                       = module.shared_components.resource_group_name
  ai_connection_string                      = module.shared_components.ai_connection_string
}

module "database" {
  source                  = "./modules/database"
  environment_name        = var.environment_name
  resource_group_location = module.shared_components.resource_group_location
  resource_group_name     = module.shared_components.resource_group_name
  pg_password             = var.pg_password
}
