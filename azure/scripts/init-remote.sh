#!/bin/bash

source ./new-resource-group-if-absent.sh
source ./new-key-vault-if-absent.sh
source ./new-service-principal-if-absent.sh

azure_login() {
    az login --use-device-code
    SUBSCRIPTION_NAME="$1"
    az account set --subscription "$SUBSCRIPTION_NAME"
}

APP_NAME_PREFIX="ml-training-room"
SUBSCRIPTION_ENV=$1
SUBSCRIPTION_NAME="$APP_NAME_PREFIX-$SUBSCRIPTION_ENV"
SERVICE_PRINCIPAL_NAME="$APP_NAME_PREFIX-principal-$SUBSCRIPTION_ENV-notf9"

azure_login "$SUBSCRIPTION_NAME"

RESOURCE_GROUP_NAME=$(grep 'resource "azurerm_resource_group"' ../modules/shared-components/01-resource_group.tf -A 3 | grep 'name\s*=' | sed -r 's/.*"(.+?)"/\1/')
RESOURCE_GROUP_NAME="$RESOURCE_GROUP_NAME-notf"
LOCATION=$(grep 'location\s*=' ../modules/shared-components/01-resource_group.tf | sed -r 's/.*"(.+?)"/\1/')

new_resource_group_if_absent "$RESOURCE_GROUP_NAME" "$LOCATION"
KEY_VAULT_NAME="mtr-kv-$SUBSCRIPTION_ENV-notf9"
new_key_vault_if_absent "$RESOURCE_GROUP_NAME" "$KEY_VAULT_NAME" "$LOCATION"

sp_result=$(new_service_principal_if_absent "$SUBSCRIPTION_ID" "$SERVICE_PRINCIPAL_NAME" "$KEY_VAULT_NAME")
echo "$sp_result"

if [ ! -d "../.terraform" ]; then
    cd ../
    terraform init
fi

printenv | grep ARM_
