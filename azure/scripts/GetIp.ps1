$IP = Invoke-RestMethod -Uri 'https://ifconfig.me'

Write-Output "{`"ip`":`"$IP`"}"
