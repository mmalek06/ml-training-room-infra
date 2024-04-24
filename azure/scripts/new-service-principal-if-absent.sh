#!/bin/bash

function new_service_principal_if_absent {
    if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
        echo "Usage: new_service_principal_if_absent <subscription_id> <service_principal_name> <key_vault_name>"
        exit 1
    fi

    local subscription_id=$1
    local service_principal_name=$2
    local key_vault_name=$3
    local secret_name="sp-pass"
    local service_principals=$(az ad sp list --filter "displayName eq '$service_principal_name'")
    local service_principal=$(echo "$service_principals" | jq -r ".[] | select(.displayName == \"$service_principal_name\")")

    if [ -n "$service_principal" ]; then
        # echo "Service principal exists, retrieving data..."

        local secret_value=$(az keyvault secret show --name $secret_name --vault-name $key_vault_name)
        local app_id=$(echo "$service_principal" | jq -r '.appId')
        local password=$(echo "$secret_value" | jq -r '.value')
    else
        # echo "Service principal doesn't exist, creating..."

        local sp_creation_output=$(az ad sp create-for-rbac --name $service_principal_name --role Contributor --scopes /subscriptions/$subscription_id --output json)
        local app_id=$(echo "$sp_creation_output" | jq -r '.appId')
        local password=$(echo "$sp_creation_output" | jq -r '.password')

        az keyvault secret set --vault-name $key_vault_name --name $secret_name --value $password
    fi

    echo "{\"AppId\": \"$app_id\", \"Password\": \"$password\"}"
}