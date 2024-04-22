#!/bin/bash

new_key_vault_if_absent() {
    local resource_group_name=$1
    local key_vault_name=$2
    local location=$3

    if az keyvault list --resource-group "$resource_group_name" --query "[?name=='$key_vault_name']" --output tsv | grep -q "$key_vault_name"; then
        echo "Key Vault $key_vault_name already exists."
    else
        echo "Creating Key Vault $key_vault_name in $resource_group_name RG, hosted in $location..."
        az keyvault create --name "$key_vault_name" --resource-group "$resource_group_name" --location "$location" --output none
    fi
}
