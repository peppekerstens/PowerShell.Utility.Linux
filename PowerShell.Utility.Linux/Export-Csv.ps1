Function Export-Csv {

[CmdletBinding(DefaultParameterSetName='Delimiter', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096608')]
param(
    [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [psobject]
    ${InputObject},

    [Parameter(Position=0)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Path},

    [Alias('PSPath','LP')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${LiteralPath},

    [switch]
    ${Force},

    [Alias('NoOverwrite')]
    [switch]
    ${NoClobber},

    [ValidateNotNullOrEmpty()]
    [System.Text.Encoding]
    ${Encoding},

    [switch]
    ${Append},

    [Parameter(ParameterSetName='Delimiter', Position=1)]
    [ValidateNotNull()]
    [char]
    ${Delimiter},

    [Parameter(ParameterSetName='UseCulture')]
    [switch]
    ${UseCulture},

    [Alias('ITI')]
    [switch]
    ${IncludeTypeInformation},

    [Alias('NTI')]
    [switch]
    ${NoTypeInformation},

    [Alias('QF')]
    [string[]]
    ${QuoteFields},

    [Alias('UQ')]
    [Microsoft.PowerShell.Commands.BaseCsvWritingCommand+QuoteKind]
    ${UseQuotes},

    [switch]
    ${NoHeader})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Export-Csv', [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters }

        $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process
{
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end
{
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}

clean
{
    if ($null -ne $steppablePipeline) {
        $steppablePipeline.Clean()
    }
}
<#

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Export-Csv
.ForwardHelpCategory Cmdlet

#>


}

