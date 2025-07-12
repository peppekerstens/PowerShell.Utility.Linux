Function Debug-Runspace {

[CmdletBinding(DefaultParameterSetName='RunspaceParameterSet', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='https://go.microsoft.com/fwlink/?LinkId=2096917')]
param(
    [Parameter(ParameterSetName='RunspaceParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [runspace]
    ${Runspace},

    [Parameter(ParameterSetName='NameParameterSet', Mandatory=$true, Position=0)]
    [string]
    ${Name},

    [Parameter(ParameterSetName='IdParameterSet', Mandatory=$true, Position=0)]
    [int]
    ${Id},

    [Parameter(ParameterSetName='InstanceIdParameterSet', Mandatory=$true, Position=0)]
    [guid]
    ${InstanceId},

    [switch]
    ${BreakAll})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Debug-Runspace', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Debug-Runspace
.ForwardHelpCategory Cmdlet

#>


}

