function New-KeyVaultIfAbsent {
    param(
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName,

        [Parameter(Mandatory=$true)]
        [string]$KeyVaultName,

        [Parameter(Mandatory=$true)]
        [string]$Location
    )

    $KeyVaultExists = az keyvault list --resource-group $ResourceGroupName | ConvertFrom-Json | Where-Object { $_.name -eq "$KeyVaultName" }

    if ($KeyVaultExists) {
        Write-Host "Key Vault $KeyVaultName already exists."
    } else {
        Write-Host "Creating Key Vault $KeyVaultName in $ResourceGroupName RG, hosted in $Location..."
        az keyvault create --name $KeyVaultName --resource-group $ResourceGroupName --location $Location
    }
}
