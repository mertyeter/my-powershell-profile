# Introduction
My PowerShell profile including:

1. PSReadLine settings to use the prompt history to make predictions on what you want to see next. You must run the command below on your terminal once.
    ```powershell
    Install-Module PSReadLine -AllowPrerelease -Force
    ```
2. Aliases for the commands I use daily.

3. Custom functions and their aliases.
    - **Clean Project:** Cleans the project folder by removing the bin and obj folders. Alias: `clean-project`
    - **Build All:** Builds all .csproj files in the current directory and its subdirectories. Alias: `build-all`
    - **DISM Restore:** Restores the Windows image to the default state. Alias: `dism-restore`
    - **Get System Errors:** Retrieves system errors from the last 12 hours. Alias: `get-sys-errors`
    - **Clear History:** Clears the PowerShell history. Alias: `clear-history`
    - **Set Azure Subscription:** Sets the Azure subscription based on the environment. Alias: `set-az-sub`
    - **List Azure SQL Firewall Rule:** Lists Azure SQL firewall rules for a specified server. Alias: `azsql-list-rule`
    - **Add Azure SQL Firewall Rule:** Adds an Azure SQL firewall rule. Alias: `azsql-add-rule`
    - **Delete Azure SQL Firewall Rule:** Deletes an Azure SQL firewall rule. Alias: `azsql-delete-rule`
    - **Git Align:** Aligns git branches by deleting branches that are gone from the remote. Alias: `git-align`
    - **Git Discard:** Discards all local changes in the git repository. Alias: `git-discard`
    - **Clean and Build Dotnet Project:** Cleans and builds the dotnet project. Alias: `dotnet-rebuild`

# Things to do before using this profile

Set up PSReadline and oh-my-posh, please have a look at Scott Hanselman's great blogpost [here](https://www.hanselman.com/blog/my-ultimate-powershell-prompt-with-oh-my-posh-and-the-windows-terminal).