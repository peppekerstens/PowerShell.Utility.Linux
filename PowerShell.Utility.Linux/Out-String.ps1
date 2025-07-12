Function Out-String {

[CmdletBinding(DefaultParameterSetName='NoNewLineFormatting', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2097024', RemotingCapability='None')]
param(
    [Parameter(ParameterSetName='StreamFormatting')]
    [switch]
    ${Stream},

    [ValidateRange(2, 2147483647)]
    [int]
    ${Width},

    [Parameter(ParameterSetName='NoNewLineFormatting')]
    [switch]
    ${NoNewline},

    [Parameter(ValueFromPipeline=$true)]
    [psobject]
    ${InputObject})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Out-String', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Out-String
.ForwardHelpCategory Cmdlet

#>


}

