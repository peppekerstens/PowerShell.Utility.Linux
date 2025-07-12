Function Register-ObjectEvent {

[CmdletBinding(HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096714')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [psobject]
    ${InputObject},

    [Parameter(Mandatory=$true, Position=1)]
    [string]
    ${EventName},

    [Parameter(Position=100)]
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

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Register-ObjectEvent', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Register-ObjectEvent
.ForwardHelpCategory Cmdlet

#>


}

