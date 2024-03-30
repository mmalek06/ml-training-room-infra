function Create-ServicePrincipalIfAbsent {
    param(
        [Parameter(Mandatory=$true)]
        [string]$SubscriptionId,

        [Parameter(Mandatory=$true)]
        [string]$ServicePrincipalName,

        [Parameter(Mandatory=$true)]
        [string]$KeyVaultName
    )

    $SecretName = "sp-pass"
    $ServicePrincipals = az ad sp list --filter "displayName eq '$ServicePrincipalName'" | ConvertFrom-Json
    $ServicePrincipal = $ServicePrincipals | Where-Object { $_.displayName -eq $ServicePrincipalName }

    if ($servicePrincipal) {
        $SecretValue = az keyvault secret show --name $SecretName --vault-name $KeyVaultName | ConvertFrom-Json
        $AppId = $ServicePrincipal.appId
        $Password = $SecretValue.value
    }
    else {
        $ServicePrincipal = az ad sp create-for-rbac --name $ServicePrincipalName --role Contributor --scopes /subscriptions/$SubscriptionId --output json | ConvertFrom-Json
        $AppId = $ServicePrincipal.appId
        $Password = $ServicePrincipal.password

        az keyvault secret set --vault-name $KeyVaultName --name $SecretName --value $Password
    }

    return @{
        AppId = $AppId
        Password = $Password
    }
}
