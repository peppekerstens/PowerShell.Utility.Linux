#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.2.0' }
<#
.Synopsis
    Pester tests for PowerShell.Utility.Linux example scripts.
.Description
    Validates that each example script in the Examples\ folder:
      - exists on disk
      - has no syntax errors (parses cleanly)
    Live execution tests for non-interactive cmdlets are guarded with -Skip:(-not $IsLinux).
    Interactive cmdlets (Out-GridView, Show-Command) are not executed in automated tests.
.Notes
    Free to use under GNU v3 Public License (https://choosealicense.com/licenses/gpl-3.0/)
    Author: Peppe Kerstens (NLD)
    Run with: Invoke-Pester .\Examples.Tests.ps1 -Output Detailed
#>

BeforeDiscovery {
    $script:ExamplesDir = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path $PSCommandPath -Parent }
    $script:ExampleFiles = @(
        'Print-SystemReport.ps1'
        'ConvertFrom-SddlString-Example.ps1'
        'Out-GridView-ProcessList.ps1'
        'Show-Command-Example.ps1'
    )
}

BeforeAll {
    $script:ExamplesDir = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path $PSCommandPath -Parent }
    if ($IsLinux) {
        $modulePath = Join-Path (Split-Path $script:ExamplesDir -Parent) 'PowerShell.Utility.Linux' 'PowerShell.Utility.Linux.psd1'
        if (Test-Path $modulePath) {
            Import-Module $modulePath -Force -ErrorAction Stop
        }
    }
}

Describe 'Example script files exist' {
    It 'Examples directory contains <_>' -ForEach $script:ExampleFiles {
        Join-Path $script:ExamplesDir $_ | Should -Exist
    }
}

Describe 'Example scripts have no syntax errors' {
    It '<_> parses without errors' -ForEach $script:ExampleFiles {
        $filePath = Join-Path $script:ExamplesDir $_
        $errors   = $null
        $null = [System.Management.Automation.Language.Parser]::ParseFile($filePath, [ref]$null, [ref]$errors)
        $errors | Should -BeNullOrEmpty
    }
}

# ---------------------------------------------------------------------------
# Module surface (Linux only — module is cross-platform but test runs on Linux)
# ---------------------------------------------------------------------------

Describe 'PowerShell.Utility.Linux module surface' -Skip:(-not $IsLinux) {

    It 'exports Out-GridView' {
        (Get-Module PowerShell.Utility.Linux).ExportedFunctions.Keys | Should -Contain 'Out-GridView'
    }
    It 'exports Out-Printer' {
        (Get-Module PowerShell.Utility.Linux).ExportedFunctions.Keys | Should -Contain 'Out-Printer'
    }
    It 'exports Show-Command' {
        (Get-Module PowerShell.Utility.Linux).ExportedFunctions.Keys | Should -Contain 'Show-Command'
    }
    It 'exports ConvertFrom-SddlString' {
        (Get-Module PowerShell.Utility.Linux).ExportedFunctions.Keys | Should -Contain 'ConvertFrom-SddlString'
    }
}

# ---------------------------------------------------------------------------
# ConvertFrom-SddlString
# ---------------------------------------------------------------------------

Describe 'ConvertFrom-SddlString-Example' {
    It 'script file exists' {
        Join-Path $script:ExamplesDir 'ConvertFrom-SddlString-Example.ps1' | Should -Exist
    }

    It 'returns an object without throwing on Linux' -Skip:(-not $IsLinux) {
        $sddl = 'O:BAG:BAD:AI(A;OICI;FA;;;SY)(A;OICI;FA;;;BA)'
        { ConvertFrom-SddlString -Sddl $sddl } | Should -Not -Throw
    }

    It 'result on Linux has RawDescriptor property matching input' -Skip:(-not $IsLinux) {
        $sddl = 'O:BAG:BAD:AI(A;OICI;FA;;;SY)'
        $result = ConvertFrom-SddlString -Sddl $sddl
        $result | Should -Not -BeNullOrEmpty
        $result.RawDescriptor | Should -Be $sddl
    }

    It 'emits a warning on Linux' -Skip:(-not $IsLinux) {
        $warnings = & {
            ConvertFrom-SddlString -Sddl 'O:BAG:BA'
        } 3>&1 | Where-Object { $_ -is [System.Management.Automation.WarningRecord] }
        $warnings | Should -Not -BeNullOrEmpty
    }
}

# ---------------------------------------------------------------------------
# Out-Printer
# ---------------------------------------------------------------------------

Describe 'Print-SystemReport' {
    It 'script file exists' {
        Join-Path $script:ExamplesDir 'Print-SystemReport.ps1' | Should -Exist
    }

    It 'Out-Printer function is exported and callable' -Skip:(-not $IsLinux) {
        # Just test that the function exists and accepts pipeline input without calling lp
        $cmd = Get-Command Out-Printer -ErrorAction SilentlyContinue
        $cmd | Should -Not -BeNullOrEmpty
    }
}

# ---------------------------------------------------------------------------
# Out-GridView  (interactive — file/syntax checks only)
# ---------------------------------------------------------------------------

Describe 'Out-GridView-ProcessList' {
    It 'script file exists' {
        Join-Path $script:ExamplesDir 'Out-GridView-ProcessList.ps1' | Should -Exist
    }
    # Out-GridView is interactive; execution is not tested in automated runs
}

# ---------------------------------------------------------------------------
# Show-Command  (interactive — file/syntax checks only)
# ---------------------------------------------------------------------------

Describe 'Show-Command-Example' {
    It 'script file exists' {
        Join-Path $script:ExamplesDir 'Show-Command-Example.ps1' | Should -Exist
    }
    # Show-Command is interactive; execution is not tested in automated runs
}
