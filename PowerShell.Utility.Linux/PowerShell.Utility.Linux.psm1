#Requires -Version 7.2

# PowerShell.Utility.Linux.psm1
# Root module for PowerShell.Utility.Linux
# Dot-sources all function files in the module folder.

$functionFiles = Get-ChildItem -Path $PSScriptRoot -Filter '*.ps1' |
    Where-Object { $_.Name -notlike '*.Tests.ps1' }
foreach ($file in $functionFiles) {
    . $file.FullName
}
