$CurrentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$IsAdmin = $CurrentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (!$IsAdmin) {
    Write-Host "Configuration of ML training room requires you run this script with admin access rights. Aborting..." -ForegroundColor Red

    return
}

Set-ExecutionPolicy Bypass -Scope Process

$ChocoOutput = Get-Command -Name choco.exe -ErrorAction SilentlyContinue

if (!$ChocoOutput) {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}
else {
    Write-Host "Chocolatey is already installed."
}

$TerraformTest = Get-Command -CommandType Cmdlet "terraform" -errorAction SilentlyContinue
$AzCliTest = Get-Command -CommandType Cmdlet "terraform" -errorAction SilentlyContinue

if ($TerraformTest -eq "") {
    choco install terraform
}
else {
    Write-Host "Terraform is already installed."
}

if ($AzCliTest -eq "") {
    choco install azure-cli
}
else {
    Write-Host "Azure Cli is already installed."
}