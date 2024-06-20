# Modülleri yükle
Import-Module -Name Terminal-Icons
Import-Module PSReadLine

# Oh My Posh temasını uygula
oh-my-posh --init --shell pwsh --config "$env:USERPROFILE\AppData\Local\Programs\oh-my-posh\themes\cloud-native-azure.omp.json" | Invoke-Expression

# PSReadLine ayarları
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView
Set-PSReadLineOption -EditMode Windows

# Aliaslar
Set-Alias -Name c -Value Clear-Host
Set-Alias -Name d -Value docker
Set-Alias -Name dc -Value "docker compose"
Set-Alias -Name k -Value kubectl

# Fonksiyonlar
function cleanProject {
    <#
    .SYNOPSIS
    Deletes bin and obj folders recursively.

    .DESCRIPTION
    This function deletes all bin and obj folders in the specified path. If -Force is not specified, it will ask for confirmation.

    .PARAMETER Path
    The root path to start cleaning. Defaults to the current directory.

    .PARAMETER Force
    Forces the deletion without asking for confirmation.

    .EXAMPLE
    cleanProject -Path "C:\MyProject" -Force
    Deletes bin and obj folders in C:\MyProject without confirmation.

    .EXAMPLE
    cleanProject -Path "C:\MyProject"
    Asks for confirmation before deleting bin and obj folders in C:\MyProject.
    #>
    param (
        [string]$Path = ".",
        [switch]$Force
    )
    $LogPath = "$env:USERPROFILE\cleanProject.log"
    if ($Force -or (Read-Host "Are you sure you want to delete bin and obj folders in $Path? (Y/N)" -eq 'Y')) {
        Get-ChildItem -Path $Path -Include bin, obj -Recurse | ForEach-Object {
            Write-Host "DELETED: $($_.FullName)"
            Remove-Item -Path $_.FullName -Force -Recurse
            Add-Content -Path $LogPath -Value "DELETED: $($_.FullName) at $(Get-Date)"
        }
    }
}

function dismRestore {
    DISM /Online /Cleanup-Image /RestoreHealth
}

function clearHistory {
    ([Microsoft.PowerShell.PSConsoleReadLine]::ClearHistory())
}

function updateSystem {
    Write-Host "Updating system..."
    Start-Process "powershell" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command Update-Help"
}

# Fonksiyonlar için aliaslar
Set-Item -Path alias:clean-project -Value cleanProject
Set-Item -Path alias:dism-restore -Value dismRestore
Set-Item -Path alias:clear-history -Value clearHistory
Set-Item -Path alias:update-system -Value updateSystem
