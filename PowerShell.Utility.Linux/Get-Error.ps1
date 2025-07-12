Function Get-Error {

[CmdletBinding(DefaultParameterSetName='Newest', HelpUri='https://go.microsoft.com/fwlink/?linkid=2241804')]
param(
    [Parameter(ParameterSetName='Error', Position=0, ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [psobject]
    ${InputObject},

    [Parameter(ParameterSetName='Newest')]
    [Alias('Last')]
    [ValidateRange(1, 2147483647)]
    [int]
    ${Newest})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Get-Error', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Get-Error
.ForwardHelpCategory Cmdlet

#>


}

