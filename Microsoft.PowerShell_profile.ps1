Import-Module -Name Terminal-Icons
Import-Module PSReadLine

oh-my-posh --init --shell pwsh --config "$env:USERPROFILE\AppData\Local\Programs\oh-my-posh\themes\cloud-native-azure.omp.json" | Invoke-Expression

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

# Function to clean the project by deleting 'bin' and 'obj' directories recursively
function cleanProject {
    Get-ChildItem .\ -include bin,obj -Recurse | ForEach-Object {
        Write-Host 'DELETED' $_.FullName
        Remove-Item $_.FullName -Force -Recurse
    }
}

# Function to build all .csproj files in the current directory and its subdirectories
function buildAll {
    $baseDir = (Get-Item -Path ".\" -Verbose).FullName
    Write-Host ("Scanning *.csproj files in " + $baseDir)
    $projectPaths = Get-ChildItem -Path $baseDir -Include *.csproj -Recurse
    Write-Host ("Total found: " + $projectPaths.Count)

    foreach ($projectPath in $projectPaths) {
        Write-Host ("Building => " + $projectPath)
        dotnet build $projectPath
    }
}

# Function to restore the Windows image to the default state using DISM
function dismRestore {
    DISM /Online /Cleanup-Image /RestoreHealth
}

# Function to get system errors from the last 12 hours
function getSystemErrors {
    Get-WinEvent -FilterHashtable @{ LogName = 'System'; StartTime = (Get-Date).AddHours(-12) } |
    Where-Object { $_.LevelDisplayName -eq "Critical" -or $_.LevelDisplayName -eq "Error" } |
    Format-List Id, LevelDisplayName, TimeCreated, Message
}

# Function to clear the PowerShell history
function clearHistory {
    [Microsoft.PowerShell.PSConsoleReadLine]::ClearHistory()
}

# Function to set the Azure subscription based on the environment
function setAzSubscription {
    param (
        [ValidateSet("dev", "test", "uat", "live")]
        [string]$env
    )

    $subscriptionId = switch ($env) {
        "dev" { "your-dev-subscription-id" }
        "test" { "your-test-subscription-id" }
        "uat" { "your-uat-subscription-id" }
        "live" { "your-live-subscription-id" }
    }

    az account set --subscription $subscriptionId
}

# Function to list Azure SQL firewall rules
function listAzSqlFirewallRule {
    param (
      [string]$resourceGroupName,
      [string]$serverName
    )

    az sql server firewall-rule list -g $resourceGroupName -s $serverName -otable
}

# Function to add an Azure SQL firewall rule
function addAzSqlFirewallRule {
    param (
        [string]$resourceGroupName,
        [string]$serverName,
        [string]$ruleName,
        [string]$startIp,
        [string]$endIp
    )

    az sql server firewall-rule create -g $resourceGroupName -s $serverName -n $ruleName --start-ip-address $startIp --end-ip-address $endIp
}

# Function to delete an Azure SQL firewall rule
function deleteAzSqlFirewallRule {
    param (
        [string]$resourceGroupName,
        [string]$serverName,
        [string]$ruleName
    )

    az sql server firewall-rule delete -g $resourceGroupName -s $serverName -n $ruleName
}

# Function to align git branches
function gitAlign {
    git checkout main
    git pull
    git fetch --prune
    git branch --v | Select-String -Pattern ".*\[gone\].*" | ForEach-Object { ($_ -split "\s+")[1] } | ForEach-Object { git branch -D $_ }
}

# Function to clean and build dotnet project
function dotnetCleanAndBuild {
    dotnet clean
    dotnet build
}

Set-Alias -Name c -Value cls
Set-Alias -Name clear-history -Value clearHistory

Set-Alias -Name d -Value docker
Set-Alias -Name dc -Value "docker compose"
Set-Alias -Name k -Value kubectl

Set-Alias -Name dism-restore -Value dismRestore
Set-Alias -Name get-sys-errors -Value getSystemErrors

Set-Alias -Name set-az-sub -Value setAzSubscription
Set-Alias -Name azsql-list-rule -Value listAzSqlFirewallRule
Set-Alias -Name azsql-add-rule -Value addAzSqlFirewallRule
Set-Alias -Name azsql-delete-rule -Value deleteAzSqlFirewallRule

Set-Alias -Name git-align -Value gitAlign
Set-Alias -Name build-all -Value buildAll
Set-Alias -Name clean-project -Value cleanProject
Set-Alias -Name dotnet-rebuild -Value dotnetCleanAndBuild
