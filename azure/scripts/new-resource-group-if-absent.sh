#!/bin/bash

new_resource_group_if_absent() {
    local resource_group_name=$1
    local location=$2

    if [ $(az group exists --name "$resource_group_name" --output tsv) = "false" ]; then
        echo "Resource Group $resource_group_name does not exist. Creating..."
        az group create --name "$resource_group_name" --location "$location" --output none
    else
        echo "Resource Group $resource_group_name already exists."
    fi
}
