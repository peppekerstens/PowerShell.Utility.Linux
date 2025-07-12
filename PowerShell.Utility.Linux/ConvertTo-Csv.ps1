Function ConvertTo-Csv {

[CmdletBinding(DefaultParameterSetName='Delimiter', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096832', RemotingCapability='None')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [psobject]
    ${InputObject},

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

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\ConvertTo-Csv', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\ConvertTo-Csv
.ForwardHelpCategory Cmdlet

#>


}

