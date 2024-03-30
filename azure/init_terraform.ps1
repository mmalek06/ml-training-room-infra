param(
    [Parameter(Mandatory=$true)]
    [string]$SubscriptionEnv
)

$AppNamePrefix = "ml-training-room"
$SubscriptionName = "$AppNamePrefix-$SubscriptionEnv"
$ServicePrincipalName = "$AppNamePrefix-principal-$SubscriptionEnv"
$LoginResult = az login
$Accounts = $LoginResult | ConvertFrom-Json
$TenantId = ($Accounts | Where-Object { $_.name -eq $SubscriptionName }).tenantId
$SubscriptionId = ($Accounts | Where-Object { $_.name -eq $SubscriptionName }).id

az account set --subscription $SubscriptionName

$KeyVaultName = "$AppNamePrefix-keyvault-$SubscriptionEnv"
$SecretName = "sp-pass"
$ServicePrincipals = az ad sp list --filter "displayName eq '$ServicePrincipalName'" | ConvertFrom-Json
$ServicePrincipal = $ServicePrincipals | Where-Object { $_.displayName -eq $ServicePrincipalName }

if ($servicePrincipal) {
    $SecretValue = az keyvault secret show --name $secretName --vault-name $KeyVaultName | ConvertFrom-Json

    if ($SecretValue) {
        $AppId = $ServicePrincipal.appId
        $Password = $SecretValue.value
    }
    else {
        Write-Host "Failed to retrieve the secret from Key Vault."
    }
}
else {
    $ServicePrincipal = az ad sp create-for-rbac --name $ServicePrincipalName --role Contributor --scopes /subscriptions/$SubscriptionId --output json | ConvertFrom-Json
    $AppId = $ServicePrincipal.appId
    $Password = $ServicePrincipal.password
}

$env:ARM_CLIENT_ID=$AppId
$env:ARM_SUBSCRIPTION_ID=$SubscriptionId
$env:ARM_TENANT_ID=$TenantId
$env:ARM_CLIENT_SECRET=$Password

gci env:ARM_*
# terraform init
