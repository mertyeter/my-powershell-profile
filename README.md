# Introduction
My PowerShell profile including:

1. PSReadLine settings to use the prompt history to make predictions on what you want to see next. You must run the command below on your terminal once.
```
Install-Module PSReadLine -AllowPrerelease -Force
```
2. Aliases for the commands I use daily.

3. Custom functions and their aliases.
    - **Clean Project:** Cleans the project folder by removing the bin and obj folders.
    - **DISM Restore:** Restores the Windows image to the default state.
    - **Clear History:** Clears the PowerShell history.

# Things to do before using this profile

1. Set up PSReadline and oh-my-posh, please have a look at Scott Hanselman's great blogpost [here](https://www.hanselman.com/blog/my-ultimate-powershell-prompt-with-oh-my-posh-and-the-windows-terminal).
2. Don't forget to replace `<username>` tag on oh-my-posh config. 