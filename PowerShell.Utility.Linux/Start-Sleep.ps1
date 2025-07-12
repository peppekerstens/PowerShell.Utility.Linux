Function Start-Sleep {

[CmdletBinding(DefaultParameterSetName='Seconds', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2097041')]
param(
    [Parameter(ParameterSetName='Seconds', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(0, 2147483)]
    [double]
    ${Seconds},

    [Parameter(ParameterSetName='Milliseconds', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('ms')]
    [ValidateRange(0, 2147483647)]
    [int]
    ${Milliseconds},

    [Parameter(ParameterSetName='FromTimeSpan', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('ts')]
    [ValidateRange([System.Management.Automation.ValidateRangeKind]::NonNegative)]
    [timespan]
    ${Duration})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Start-Sleep', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Start-Sleep
.ForwardHelpCategory Cmdlet

#>


}

