Function Set-PSBreakpoint {

[CmdletBinding(DefaultParameterSetName='Line', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096623')]
param(
    [Parameter(ParameterSetName='Command')]
    [Parameter(ParameterSetName='Line')]
    [Parameter(ParameterSetName='Variable')]
    [scriptblock]
    ${Action},

    [Parameter(ParameterSetName='Line', Position=2)]
    [ValidateRange(1, 2147483647)]
    [int]
    ${Column},

    [Parameter(ParameterSetName='Command', Mandatory=$true)]
    [Alias('C')]
    [string[]]
    ${Command},

    [Parameter(ParameterSetName='Line', Mandatory=$true, Position=1)]
    [int[]]
    ${Line},

    [Parameter(ParameterSetName='Command', Position=0)]
    [Parameter(ParameterSetName='Line', Mandatory=$true, Position=0)]
    [Parameter(ParameterSetName='Variable', Position=0)]
    [ValidateNotNull()]
    [string[]]
    ${Script},

    [Parameter(ParameterSetName='Variable', Mandatory=$true)]
    [Alias('V')]
    [string[]]
    ${Variable},

    [Parameter(ParameterSetName='Variable')]
    [System.Management.Automation.VariableAccessMode]
    ${Mode},

    [ValidateNotNull()]
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

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Set-PSBreakpoint', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Set-PSBreakpoint
.ForwardHelpCategory Cmdlet

#>


}

