Function Remove-PSBreakpoint {

[CmdletBinding(DefaultParameterSetName='Breakpoint', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2097134')]
param(
    [Parameter(ParameterSetName='Breakpoint', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [System.Management.Automation.Breakpoint[]]
    ${Breakpoint},

    [Parameter(ParameterSetName='Id', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [int[]]
    ${Id},

    [Parameter(ParameterSetName='Id', ValueFromPipelineByPropertyName=$true)]
    [Alias('RunspaceId')]
    [runspace]
    ${Runspace})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Remove-PSBreakpoint', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Remove-PSBreakpoint
.ForwardHelpCategory Cmdlet

#>


}

