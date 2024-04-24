#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <subscription_env>"
  exit 1
fi

subscription_env=$1

. ./new-resource-group-if-absent.sh
. ./new-key-vault-if-absent.sh
. ./new-service-principal-if-absent.sh

counter=10
app_name_prefix="ml-training-room"
subscription_name="${app_name_prefix}-${subscription_env}"
service_principal_name="${app_name_prefix}-principal-${subscription_env}-notf-${counter}"

login_result=$(az login)
tenant_id=$(echo $login_result | jq -r ".[] | select(.name == \"$subscription_name\") | .tenantId")
subscription_id=$(echo $login_result | jq -r ".[] | select(.name == \"$subscription_name\") | .id")

az account set --subscription "$subscription_name"

key_vault_name="mltr-kv-${subscription_env}-notf-${counter}"
terraform_file_contents=$(cat "../modules/shared-components/01-resource_group.tf")
resource_group_name="mltr-resources"
resource_group_name="${resource_group_name}-notf"
location=$(echo "$terraform_file_contents" | grep -oP 'location = "\K(.+?)(?=")')

new_resource_group_if_absent "$resource_group_name" "$location"
new_key_vault_if_absent "$resource_group_name" "$key_vault_name" "$location"

sp_result=$(new_service_principal_if_absent "$subscription_id" "$service_principal_name" "$key_vault_name")
app_id=$(echo "$sp_result" | jq -r '.AppId')
password=$(echo "$sp_result" | jq -r '.Password')

export ARM_CLIENT_ID="$app_id"
export ARM_SUBSCRIPTION_ID="$subscription_id"
export ARM_TENANT_ID="$tenant_id"
export ARM_CLIENT_SECRET="$password"

printenv | grep ARM_

terraform_already_initialized=$(test -d "../.terraform" && echo "yes" || echo "no")

if [ "$terraform_already_initialized" != "yes" ]; then
    cd ../
    terraform init
fi
