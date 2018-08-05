[![Build status](https://ci.appveyor.com/api/projects/status/aonepjox78v7xhff?svg=true)](https://ci.appveyor.com/project/ozthe2/ohtools)

# OHTools

# One time setup
    # Download the repository
    # Unblock the zip
    # Extract the OHTools folder to a module path (e.g. $env:USERPROFILE\Documents\WindowsPowerShell\Modules\)

    #Simple alternative, if you have PowerShell 5, or the PowerShellGet module:
    (This is coming soon - does not work yet!)    Install-Module OHTools

# Import the module.
    Import-Module OHTools    #Alternatively, Import-Module \\Path\To\OHTools

# Get commands in the module
    Get-Command -Module OHTools

# Get help
    Get-Help Get-OHComputerInfo -Full
    Get-Help about_OHTools