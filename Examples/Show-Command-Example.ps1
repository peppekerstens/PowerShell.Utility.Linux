<#
.Synopsis
    Opens an interactive command browser to explore available cmdlets.
.Description
    Uses Show-Command to present an interactive TUI (Linux) or GUI (Windows) panel
    that lets you browse all available commands, inspect parameter sets, and
    optionally build a command line to run.
    On Linux, uses Microsoft.PowerShell.ConsoleGuiTools (installed automatically if needed).
    This script is meant for interactive use; run it from a terminal session.
    Works identically on Windows (via Microsoft.PowerShell.Utility) and Linux (via PowerShell.Utility.Linux).
.Example
    .\Show-Command-Example.ps1
.Example
    .\Show-Command-Example.ps1   # then type 'Get-*' to filter commands
.Notes
    Free to use under GNU v3 Public License (https://choosealicense.com/licenses/gpl-3.0/)
    Author: Peppe Kerstens (NLD)
    Requires: PowerShell.Utility.Linux (Linux) or Microsoft.PowerShell.Utility (Windows)
    On Linux also requires: Microsoft.PowerShell.ConsoleGuiTools (installed automatically)
#>

#Requires -Modules PowerShell.Utility.Linux

# Open the command browser for all Get- cmdlets
Show-Command -Name 'Get-*'
