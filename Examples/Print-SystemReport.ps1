<#
.Synopsis
    Prints a formatted system report to the default printer.
.Description
    Collects key environment information ($PSVersionTable, running processes, environment
    variables) and sends it to the system default printer via Out-Printer.
    On Linux, requires CUPS: sudo apt-get install cups
    Works identically on Windows (via Microsoft.PowerShell.Utility) and Linux (via PowerShell.Utility.Linux).
.Example
    .\Print-SystemReport.ps1
.Example
    .\Print-SystemReport.ps1 -PrinterName HP_LaserJet
.Notes
    Free to use under GNU v3 Public License (https://choosealicense.com/licenses/gpl-3.0/)
    Author: Peppe Kerstens (NLD)
    Requires: PowerShell.Utility.Linux (Linux) or Microsoft.PowerShell.Utility (Windows)
#>

#Requires -Modules PowerShell.Utility.Linux

param(
    [string]$PrinterName
)

$reportLines = @(
    "=== PowerShell System Report ==="
    "Generated : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    "Host      : $($env:COMPUTERNAME ?? (hostname))"
    ""
    "--- PowerShell Version ---"
)
$reportLines += $PSVersionTable | Format-List | Out-String
$reportLines += @(
    "--- Top 10 Processes by CPU ---"
)
$reportLines += Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 |
    Format-Table Name, Id, CPU, WorkingSet -AutoSize | Out-String

$report = $reportLines -join "`n"

$printParams = @{ InputObject = $report }
if ($PrinterName) { $printParams['Name'] = $PrinterName }

Out-Printer @printParams
