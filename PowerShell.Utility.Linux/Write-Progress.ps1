Function Write-Progress {

[CmdletBinding(HelpUri='https://go.microsoft.com/fwlink/?LinkID=2097036', RemotingCapability='None')]
param(
    [Parameter(Position=0)]
    [string]
    ${Activity},

    [Parameter(Position=1)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Status},

    [Parameter(Position=2)]
    [ValidateRange(0, 2147483647)]
    [int]
    ${Id},

    [ValidateRange(-1, 100)]
    [int]
    ${PercentComplete},

    [int]
    ${SecondsRemaining},

    [string]
    ${CurrentOperation},

    [ValidateRange(-1, 2147483647)]
    [int]
    ${ParentId},

    [switch]
    ${Completed},

    [int]
    ${SourceId})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Write-Progress', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Write-Progress
.ForwardHelpCategory Cmdlet

#>


}

