function New-ResourceGroupIfAbsent {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName,

        [Parameter(Mandatory=$true)]
        [string]$Location
    )
    
    $ResourceGroupExists = az group exists --name $ResourceGroupName
    
    if (-not $ResourceGroupExists -or $ResourceGroupExists -eq "false") {
        Write-Host "Resource Group $ResourceGroupName does not exist. Creating..."
        az group create --name $ResourceGroupName --location "$Location"
    } else {
        Write-Host "Resource Group $ResourceGroupName already exists."
    }
}
