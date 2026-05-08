<#
.Synopsis
    Opens an interactive grid view showing running processes.
.Description
    Pipes Get-Process into Out-GridView to display an interactive, filterable list.
    On Linux, uses Out-ConsoleGridView (Microsoft.PowerShell.ConsoleGuiTools) in the terminal.
    On Windows, opens the standard GUI grid view window.
    This script is meant for interactive use; run it from a terminal session.
    Works identically on Windows (via Microsoft.PowerShell.Utility) and Linux (via PowerShell.Utility.Linux).
.Example
    .\Out-GridView-ProcessList.ps1
.Notes
    Free to use under GNU v3 Public License (https://choosealicense.com/licenses/gpl-3.0/)
    Author: Peppe Kerstens (NLD)
    Requires: PowerShell.Utility.Linux (Linux) or Microsoft.PowerShell.Utility (Windows)
    On Linux also requires: Microsoft.PowerShell.ConsoleGuiTools (installed automatically)
#>

#Requires -Modules PowerShell.Utility.Linux

Get-Process |
    Select-Object -Property Name, Id, CPU, WorkingSet, StartTime |
    Sort-Object CPU -Descending |
    Out-GridView -Title 'Running Processes'
