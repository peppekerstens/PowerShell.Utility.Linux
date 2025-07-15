Describe 'Out-Gridview.ps1' {
    BeforeAll {
        # Import the script
        . $PSScriptRoot/../PowerShell.Utility.Linux/Out-GridView.ps1
    }

    Context 'Get-OutGridviewSettings' {
        It 'Returns default settings if file does not exist' {
            Mock Get-Content { throw }
            Mock Set-Content {}
            $result = Get-OutGridviewSettings
            $result.ViewDefault | Should -Be 'Gui'
        }
        It 'Returns settings from file if exists' {
            $json = '{"ViewDefault":"Console"}'
            Mock Get-Content { $json }
            Mock ConvertFrom-Json { @{ ViewDefault = 'Console' } }
            $result = Get-OutGridviewSettings
            $result.ViewDefault | Should -Be 'Console'
        }
    }

    Context 'Test-ConsoleGuiTools' {
        It 'Returns true if module is available' {
            Mock Get-Module { @{ Name = 'microsoft.powershell.consoleguitools' } }
            Test-ConsoleGuiTools | Should -Be $true
        }
        It 'Returns false if module is not available' {
            Mock Get-Module { $null }
            Test-ConsoleGuiTools | Should -Be $false
        }
    }

    Context 'Set-ConsoleGuiTools' {
        It 'Installs and imports module if not available' {
            Mock Test-ConsoleGuiTools { $false }
            Mock install-module {}
            Mock import-module {}
            { Set-ConsoleGuiTools } | Should -Not -Throw
        }
        It 'Does nothing if module is available' {
            Mock Test-ConsoleGuiTools { $true }
            { Set-ConsoleGuiTools } | Should -Not -Throw
        }
    }

    Context 'Out-Gridview' {
        It 'Sets ViewDefault and saves settings' {
            Mock Set-Content {}
            $params = @{ ViewDefault = 'Console' }
            $null = Out-Gridview @params
            # Should call Set-Content with correct value
            Assert-MockCalled Set-Content -Exactly 1 -Scope It
        }
        It 'Removes ViewDefault from PSBoundParameters' {
            Mock Set-Content {}
            $params = @{ ViewDefault = 'Gui' }
            $null = Out-Gridview @params
            # Should call Set-Content
            Assert-MockCalled Set-Content -Exactly 1 -Scope It
        }
    }
}
