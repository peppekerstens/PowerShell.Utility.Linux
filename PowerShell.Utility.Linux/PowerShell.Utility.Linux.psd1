#
# Module manifest for module 'PowerShell.Utility.Linux'
#

@{
    RootModule        = 'PowerShell.Utility.Linux.psm1'
    ModuleVersion     = '0.4.0'
    GUID              = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
    Author            = 'Peppe Kerstens'
    CompanyName       = ''
    Copyright         = '(c) Peppe Kerstens. GPL-3.0 license.'
    Description       = 'PowerShell module for Linux providing cmdlet parity with Microsoft.PowerShell.Utility. Implements Out-GridView, Out-Printer, Show-Command and ConvertFrom-SddlString as cross-platform functions.'
    PowerShellVersion = '7.2'

    # No external module dependencies declared here; ConsoleGuiTools is installed
    # on demand inside Out-GridView and Show-Command to avoid cross-platform install errors.
    RequiredModules   = @()

    FunctionsToExport = @(
        'Out-GridView',
        'Out-Printer',
        'Show-Command',
        'ConvertFrom-SddlString'
    )

    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()

    PrivateData = @{
        PSData = @{
            Tags         = @('Linux', 'Utility', 'Out-GridView', 'Out-Printer', 'Show-Command', 'CrossPlatform')
            LicenseUri   = 'https://github.com/peppekerstens/PowerShell.Utility.Linux/blob/main/LICENSE'
            ProjectUri   = 'https://github.com/peppekerstens/PowerShell.Utility.Linux'
            ReleaseNotes = @'
0.3.0 - Out-Printer: full Linux implementation via lp/CUPS; Show-Command: TUI implementation via ConsoleGuiTools on Linux, Windows fallback retained.
0.2.0 - Out-GridView: cross-platform via ConsoleGuiTools; settings persistence added.
0.1.0 - Initial scaffolding.
'@
        }
    }
}
