Function Compare-Object {

[CmdletBinding(HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096605', RemotingCapability='None')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [AllowEmptyCollection()]
    [psobject[]]
    ${ReferenceObject},

    [Parameter(Mandatory=$true, Position=1, ValueFromPipeline=$true)]
    [AllowEmptyCollection()]
    [psobject[]]
    ${DifferenceObject},

    [ValidateRange(0, 2147483647)]
    [int]
    ${SyncWindow},

    [System.Object[]]
    ${Property},

    [switch]
    ${ExcludeDifferent},

    [switch]
    ${IncludeEqual},

    [switch]
    ${PassThru},

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

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Compare-Object', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Compare-Object
.ForwardHelpCategory Cmdlet

#>


}

