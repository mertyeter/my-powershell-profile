Import-Module -Name Terminal-Icons
Import-Module PSReadLine

oh-my-posh --init --shell pwsh --config C:\Users\<username>\AppData\Local\Programs\oh-my-posh\themes\cloud-native-azure.omp.json | Invoke-Expression

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

Set-Alias -Name c -Value cls
Set-Alias -Name d -Value docker
Set-Alias -Name dc -Value "docker compose"
Set-Alias -Name k -Value kubectl

function cleanProject
{
   Get-ChildItem .\ -include bin,obj -Recurse | ForEach-Object ($_) { Write-Host 'DELETED'$_.FullName; Remove-Item $_.FullName -Force -Recurse }
}

function dismRestore
{
   DISM /Online /Cleanup-Image /RestoreHealth
}

function clearHistory
{
   ([Microsoft.PowerShell.PSConsoleReadLine]::ClearHistory())
}

Set-Item -Path alias:clean-project -Value cleanProject
Set-Item -Path alias:dism-restore -Value dismRestore
Set-Item -Path alias:clear-history -Value clearHistory