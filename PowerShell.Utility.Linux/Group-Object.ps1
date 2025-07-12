Function Group-Object {

[CmdletBinding(HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096619', RemotingCapability='None')]
param(
    [switch]
    ${NoElement},

    [Parameter(ParameterSetName='HashTable')]
    [Alias('AHT')]
    [switch]
    ${AsHashTable},

    [Parameter(ParameterSetName='HashTable')]
    [switch]
    ${AsString},

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

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Group-Object', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Group-Object
.ForwardHelpCategory Cmdlet

#>


}

