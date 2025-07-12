Function New-Event {

[CmdletBinding(HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096708')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]
    ${SourceIdentifier},

    [Parameter(Position=1)]
    [psobject]
    ${Sender},

    [Parameter(Position=2)]
    [psobject[]]
    ${EventArguments},

    [Parameter(Position=3)]
    [psobject]
    ${MessageData})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\New-Event', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\New-Event
.ForwardHelpCategory Cmdlet

#>


}

