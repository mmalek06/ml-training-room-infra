param(
    [Parameter(Mandatory=$true)]
    [string]$SubscriptionEnv
)

. ./NewResourceGroupIfAbsent.ps1
. ./NewKeyVaultIfAbsent.ps1
. ./NewServicePrincipalIfAbsent.ps1

$Counter = 10
$AppNamePrefix = "ml-training-room"
$SubscriptionName = "$AppNamePrefix-$SubscriptionEnv"
$ServicePrincipalName = "$AppNamePrefix-principal-$SubscriptionEnv-notf-$Counter"
$LoginResult = az login
$Accounts = $LoginResult | ConvertFrom-Json
$TenantId = ($Accounts | Where-Object { $_.name -eq $SubscriptionName }).tenantId
$SubscriptionId = ($Accounts | Where-Object { $_.name -eq $SubscriptionName }).id

az account set --subscription $SubscriptionName

$KeyVaultName = "mltr-kv-$SubscriptionEnv-notf-$Counter"
$TerraformFileContents = Get-Content "../modules/shared-components/01-resource_group.tf" -Raw
$ResourceGroupName = [regex]::Match($TerraformFileContents, 'resource "azurerm_resource_group" ".*?" {\s*name\s*=\s*"(.+?)"').Groups[1].Value
$ResourceGroupName = "$ResourceGroupName-notf"
$Location = [regex]::Match($TerraformFileContents, 'location = "(.+?)"').Groups[1].Value

New-ResourceGroupIfAbsent -ResourceGroupName $ResourceGroupName -Location $Location
New-KeyVaultIfAbsent -ResourceGroupName $ResourceGroupName -KeyVaultName $KeyVaultName -Location $Location

$SpResult = New-ServicePrincipalIfAbsent -SubscriptionId $SubscriptionId -ServicePrincipalName $ServicePrincipalName -KeyVaultName $KeyVaultName
$AppId = $SpResult.AppId
$Password = $SpResult.Password
# these will automatically be detected and used by terraform
$env:ARM_CLIENT_ID=$AppId
$env:ARM_SUBSCRIPTION_ID=$SubscriptionId
$env:ARM_TENANT_ID=$TenantId
$env:ARM_CLIENT_SECRET=$Password

Get-ChildItem env:ARM_*

$TerraformAlreadyInitialized = Test-Path -Path "../.terraform" -PathType Container

if (-not $TerraformAlreadyInitialized) {
    cd ../
    terraform init
}
