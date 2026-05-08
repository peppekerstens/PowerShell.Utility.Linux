function Out-Printer {
    <#
    .Synopsis
        Sends output to a printer.
    .Description
        Cross-platform implementation of Out-Printer.
        On Windows, delegates to the built-in Microsoft.PowerShell.Utility\Out-Printer cmdlet.
        On Linux, converts input to text and sends it to the lp command (CUPS).
        Requires CUPS to be installed on Linux: sudo apt-get install cups
    .Parameter InputObject
        The objects to print. Enter a variable that contains the objects, or type a command or
        expression that gets the objects.
    .Parameter Name
        The name of the printer. If omitted, the default printer is used.
        On Linux this maps to the lp -d <destination> option.
    .Notes
        Free to use under GNU v3 Public License (https://choosealicense.com/licenses/gpl-3.0/)
        Author: Peppe Kerstens (NLD)
        Version: 1.0.0
        Date: 2025-07-16
    .Link
        https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/out-printer
    #>
    [CmdletBinding(HelpUri='https://go.microsoft.com/fwlink/?LinkID=2109553')]
    param(
        [Parameter(Position=0)]
        [Alias('PrinterName')]
        [string]
        ${Name},

        [Parameter(ValueFromPipeline=$true)]
        [psobject]
        ${InputObject}
    )

    begin {
        if ($IsLinux) {
            if (-not (Get-Command lp -ErrorAction SilentlyContinue)) {
                throw "Out-Printer: 'lp' command not found. Install CUPS: sudo apt-get install cups"
            }
            $buffer = [System.Collections.Generic.List[string]]::new()
        } else {
            try {
                $outBuffer = $null
                if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
                    $PSBoundParameters['OutBuffer'] = 1
                }
                $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(
                    'Microsoft.PowerShell.Utility\Out-Printer',
                    [System.Management.Automation.CommandTypes]::Cmdlet)
                $scriptCmd = { & $wrappedCmd @PSBoundParameters }
                $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
                $steppablePipeline.Begin($PSCmdlet)
            } catch {
                throw
            }
        }
    }

    process {
        if ($IsLinux) {
            if ($null -ne $InputObject) {
                $buffer.Add(($InputObject | Out-String))
            }
        } else {
            try {
                $steppablePipeline.Process($_)
            } catch {
                throw
            }
        }
    }

    end {
        if ($IsLinux) {
            $text = $buffer -join "`n"
            if ([string]::IsNullOrWhiteSpace($text)) { return }
            $lpArgs = @()
            if ($PSBoundParameters.ContainsKey('Name') -and -not [string]::IsNullOrEmpty($Name)) {
                $lpArgs += '-d', $Name
            }
            $tmpFile = [System.IO.Path]::GetTempFileName()
            try {
                $text | Set-Content -Path $tmpFile -Encoding UTF8
                $lpArgs += $tmpFile
                & lp @lpArgs
                if ($LASTEXITCODE -ne 0) {
                    Write-Error "Out-Printer: lp returned exit code $LASTEXITCODE"
                }
            } finally {
                Remove-Item -Path $tmpFile -ErrorAction SilentlyContinue
            }
        } else {
            try {
                $steppablePipeline.End()
            } catch {
                throw
            }
        }
    }

    <#
    .ForwardHelpTargetName Microsoft.PowerShell.Utility\Out-Printer
    .ForwardHelpCategory Cmdlet
    #>
}

