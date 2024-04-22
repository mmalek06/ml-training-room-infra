#!/bin/bash

new_service_principal_if_absent() {
    local subscription_id=$1
    local service_principal_name=$2
    local key_vault_name=$3

    secret_name="sp-pass"
    if az ad sp list --filter "displayName eq '$service_principal_name'" --query "[].displayName" --output tsv | grep -q "$service_principal_name"; then
        echo "Service principal exists, retrieving data..."
        secret_value=$(az keyvault secret show --name "$secret_name" --vault-name "$key_vault_name" --query "value" --output tsv)
        app_id=$(az ad sp show --id "$service_principal_name" --query "appId" --output tsv)
        password="$secret_value"
    else
        echo "Service principal doesn't exist, creating..."
        creds=$(az ad sp create-for-rbac --name "$service_principal_name" --role Contributor --scopes "/subscriptions/$subscription_id" --output json)
        app_id=$(echo $creds | jq -r '.appId')
        password=$(echo $creds | jq -r '.password')

        az keyvault secret set --vault-name "$key_vault_name" --name "$secret_name" --value "$password" --output none
    fi

    export ARM_CLIENT_ID="$app_id"
    export ARM_SUBSCRIPTION_ID="$subscription_id"
    export ARM_TENANT_ID=$(az account show --query "tenantId" --output tsv)
    export ARM_CLIENT_SECRET="$password"
}
