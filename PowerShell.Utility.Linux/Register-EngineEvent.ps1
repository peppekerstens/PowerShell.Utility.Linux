Function Register-EngineEvent {

[CmdletBinding(HelpUri='https://go.microsoft.com/fwlink/?LinkID=2097128')]
param(
    [Parameter(Mandatory=$true, Position=100)]
    [string]
    ${SourceIdentifier},

    [Parameter(Position=101)]
    [scriptblock]
    ${Action},

    [psobject]
    ${MessageData},

    [switch]
    ${SupportEvent},

    [switch]
    ${Forward},

    [int]
    ${MaxTriggerCount})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Register-EngineEvent', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Register-EngineEvent
.ForwardHelpCategory Cmdlet

#>


}

