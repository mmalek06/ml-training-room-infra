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

module "hello_function" {
  source                                    = "./modules/hello-function"
  environment_name                          = var.environment_name
  storage_account_name                      = module.shared_components.storage_account_name
  storage_account_primary_connection_string = module.shared_components.storage_account_primary_connection_string
  storage_account_primary_access_key        = module.shared_components.storage_account_primary_access_key
  resource_group_location                   = module.shared_components.resource_group_location
  resource_group_name                       = module.shared_components.resource_group_name
}

module "network_security" {
  source                     = "./modules/network_security"
  storage_account_id         = module.shared_components.storage_account_id
  network_rules_dependencies = [module.hello_function.hello_function_container]
  subnet_id                  = module.shared_components.subnet_id
}
