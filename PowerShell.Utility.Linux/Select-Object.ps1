Function Select-Object {

[CmdletBinding(DefaultParameterSetName='DefaultParameter', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096716', RemotingCapability='None')]
param(
    [Parameter(ValueFromPipeline=$true)]
    [psobject]
    ${InputObject},

    [Parameter(ParameterSetName='DefaultParameter', Position=0)]
    [Parameter(ParameterSetName='SkipLastParameter', Position=0)]
    [System.Object[]]
    ${Property},

    [Parameter(ParameterSetName='DefaultParameter')]
    [Parameter(ParameterSetName='SkipLastParameter')]
    [string[]]
    ${ExcludeProperty},

    [Parameter(ParameterSetName='DefaultParameter')]
    [Parameter(ParameterSetName='SkipLastParameter')]
    [string]
    ${ExpandProperty},

    [switch]
    ${Unique},

    [switch]
    ${CaseInsensitive},

    [Parameter(ParameterSetName='DefaultParameter')]
    [ValidateRange(0, 2147483647)]
    [int]
    ${Last},

    [Parameter(ParameterSetName='DefaultParameter')]
    [ValidateRange(0, 2147483647)]
    [int]
    ${First},

    [Parameter(ParameterSetName='DefaultParameter')]
    [Parameter(ParameterSetName='SkipLastParameter')]
    [ValidateRange(0, 2147483647)]
    [int]
    ${Skip},

    [Parameter(ParameterSetName='SkipLastParameter')]
    [ValidateRange(0, 2147483647)]
    [int]
    ${SkipLast},

    [Parameter(ParameterSetName='DefaultParameter')]
    [Parameter(ParameterSetName='IndexParameter')]
    [switch]
    ${Wait},

    [Parameter(ParameterSetName='IndexParameter')]
    [ValidateRange(0, 2147483647)]
    [int[]]
    ${Index},

    [Parameter(ParameterSetName='SkipIndexParameter')]
    [ValidateRange(0, 2147483647)]
    [int[]]
    ${SkipIndex})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Select-Object', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Select-Object
.ForwardHelpCategory Cmdlet

#>


}

