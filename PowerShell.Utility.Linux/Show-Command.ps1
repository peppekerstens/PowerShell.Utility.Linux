Function Show-Command {

[CmdletBinding(HelpUri='https://go.microsoft.com/fwlink/?LinkID=2109589')]
param(
    [Parameter(Position=0)]
    [Alias('CommandName')]
    [string]
    ${Name},

    [ValidateRange(300, 2147483647)]
    [double]
    ${Height},

    [ValidateRange(300, 2147483647)]
    [double]
    ${Width},

    [switch]
    ${NoCommonParameter},

    [switch]
    ${ErrorPopup},

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

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Show-Command', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Show-Command
.ForwardHelpCategory Cmdlet

#>


}

