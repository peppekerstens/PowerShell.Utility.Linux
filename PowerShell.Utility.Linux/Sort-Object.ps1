Function Sort-Object {

[CmdletBinding(DefaultParameterSetName='Default', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2097038', RemotingCapability='None')]
param(
    [Parameter(ParameterSetName='Default')]
    [switch]
    ${Stable},

    [switch]
    ${Descending},

    [switch]
    ${Unique},

    [Parameter(ParameterSetName='Top', Mandatory=$true)]
    [ValidateRange(1, 2147483647)]
    [int]
    ${Top},

    [Parameter(ParameterSetName='Bottom', Mandatory=$true)]
    [ValidateRange(1, 2147483647)]
    [int]
    ${Bottom},

    [Parameter(ValueFromPipeline=$true)]
    [psobject]
    ${InputObject},

    [Parameter(Position=0)]
    [System.Object[]]
    ${Property},

    [string]
    ${Culture},

    [switch]
    ${CaseSensitive})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Sort-Object', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Sort-Object
.ForwardHelpCategory Cmdlet

#>


}

