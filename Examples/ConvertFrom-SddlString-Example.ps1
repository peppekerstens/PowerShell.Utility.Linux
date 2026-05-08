<#
.Synopsis
    Parses a Windows SDDL security descriptor string into a readable object.
.Description
    Uses ConvertFrom-SddlString to break down an SDDL string into its Owner,
    Group, DACL and SACL components.
    On Windows, uses the full built-in implementation.
    On Linux, emits a warning and returns the raw SDDL (Linux has no native SDDL support).
    Works on both platforms via PowerShell.Utility.Linux.
.Example
    .\ConvertFrom-SddlString-Example.ps1
.Notes
    Free to use under GNU v3 Public License (https://choosealicense.com/licenses/gpl-3.0/)
    Author: Peppe Kerstens (NLD)
    Requires: PowerShell.Utility.Linux (Linux) or Microsoft.PowerShell.Utility (Windows)
#>

#Requires -Modules PowerShell.Utility.Linux

# Example SDDL: Owner=BUILTIN\Administrators, DACL allows SYSTEM and Admins full control
$sddl = 'O:BAG:BAD:AI(A;OICI;FA;;;SY)(A;OICI;FA;;;BA)(A;OICI;0x1200a9;;;BU)'

Write-Host "SDDL: $sddl" -ForegroundColor Cyan
Write-Host ""

$descriptor = ConvertFrom-SddlString -Sddl $sddl

Write-Host "Owner            : $($descriptor.Owner ?? $descriptor.RawDescriptor)"
Write-Host "Group            : $($descriptor.Group)"
Write-Host "Discretionary ACL: $($descriptor.DiscretionaryAcl.Count) entries"
