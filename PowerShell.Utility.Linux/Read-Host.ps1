Function Read-Host {

[CmdletBinding(DefaultParameterSetName='AsString', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096610')]
param(
    [Parameter(Position=0, ValueFromRemainingArguments=$true)]
    [AllowNull()]
    [System.Object]
    ${Prompt},

    [Parameter(ParameterSetName='AsSecureString')]
    [switch]
    ${AsSecureString},

    [Parameter(ParameterSetName='AsString')]
    [switch]
    ${MaskInput})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Read-Host', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Read-Host
.ForwardHelpCategory Cmdlet

#>


}

