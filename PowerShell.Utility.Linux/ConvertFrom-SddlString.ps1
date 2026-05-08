function ConvertFrom-SddlString {
    <#
    .Synopsis
        Converts an SDDL string to a custom object.
    .Description
        Cross-platform implementation of ConvertFrom-SddlString.
        On Windows, delegates to the built-in Microsoft.PowerShell.Utility\ConvertFrom-SddlString.
        On Linux, SDDL is a Windows ACL concept with no native equivalent; a warning is emitted
        and a minimal object with the raw SDDL is returned.
    .Parameter Sddl
        The SDDL string to convert.
    .Parameter Type
        The type of access rights to use for interpretation (Windows only).
    .Notes
        Free to use under GNU v3 Public License (https://choosealicense.com/licenses/gpl-3.0/)
        Author: Peppe Kerstens (NLD)
        Version: 1.1.0
        Date: 2026-05-08
    .Link
        https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/convertfrom-sddlstring
    #>
    [CmdletBinding(HelpUri='https://go.microsoft.com/fwlink/?LinkId=623636')]
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
        [string]$Sddl
    )

    if (-not $IsLinux) {
        Microsoft.PowerShell.Utility\ConvertFrom-SddlString -Sddl $Sddl
        return
    }

    # Linux stub — SDDL is a Windows-specific ACL format
    Write-Warning "ConvertFrom-SddlString: SDDL is a Windows ACL concept. On Linux, only the raw SDDL string is returned."
    [PSCustomObject]@{
        RawDescriptor            = $Sddl
        Owner                    = $null
        Group                    = $null
        DiscretionaryAcl         = @()
        SystemAcl                = @()
    }
}
