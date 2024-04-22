#!/bin/bash

if ! command -v terraform &> /dev/null; then
    echo "Terraform is not installed, installing..."
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
    gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update
    sudo apt-get install terraform
else
    echo "Terraform is already installed."
fi

if ! command -v az &> /dev/null; then
    echo "Azure CLI is not installed, installing..."
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
else
    echo "Azure CLI is already installed."
fi
