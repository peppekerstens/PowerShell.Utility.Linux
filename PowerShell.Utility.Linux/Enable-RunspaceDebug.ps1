Function Enable-RunspaceDebug {

[CmdletBinding(DefaultParameterSetName='RunspaceNameParameterSet', HelpUri='https://go.microsoft.com/fwlink/?LinkId=2096831')]
param(
    [Parameter(ParameterSetName='RunspaceParameterSet', Position=1)]
    [Parameter(ParameterSetName='RunspaceNameParameterSet', Position=1)]
    [Parameter(ParameterSetName='RunspaceIdParameterSet', Position=1)]
    [switch]
    ${BreakAll},

    [Parameter(ParameterSetName='RunspaceNameParameterSet', Position=0)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${RunspaceName},

    [Parameter(ParameterSetName='RunspaceParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [runspace[]]
    ${Runspace},

    [Parameter(ParameterSetName='RunspaceIdParameterSet', Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [int[]]
    ${RunspaceId},

    [Parameter(ParameterSetName='RunspaceInstanceIdParameterSet', Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [guid[]]
    ${RunspaceInstanceId},

    [Parameter(ParameterSetName='ProcessNameParameterSet', Position=0)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${ProcessName},

    [Parameter(ParameterSetName='ProcessNameParameterSet', Position=1)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${AppDomainName})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Enable-RunspaceDebug', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Enable-RunspaceDebug
.ForwardHelpCategory Cmdlet

#>


}

