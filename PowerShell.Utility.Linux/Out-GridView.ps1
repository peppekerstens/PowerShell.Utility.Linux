Function Out-GridView {

[CmdletBinding(DefaultParameterSetName='PassThru', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2109378')]
param(
    [Parameter(ValueFromPipeline=$true)]
    [psobject]
    ${InputObject},

    [ValidateNotNullOrEmpty()]
    [string]
    ${Title},

    [Parameter(ParameterSetName='Wait')]
    [switch]
    ${Wait},

    [Parameter(ParameterSetName='OutputMode')]
    [Microsoft.PowerShell.Commands.OutputModeOption]
    ${OutputMode},

    [Parameter(ParameterSetName='PassThru')]
    [switch]
    ${PassThru})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Out-GridView', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Out-GridView
.ForwardHelpCategory Cmdlet

#>


}

