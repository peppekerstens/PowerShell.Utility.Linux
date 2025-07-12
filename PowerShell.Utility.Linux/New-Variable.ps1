Function New-Variable {

[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Low', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2097121')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [string]
    ${Name},

    [Parameter(Position=1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [System.Object]
    ${Value},

    [string]
    ${Description},

    [System.Management.Automation.ScopedItemOptions]
    ${Option},

    [System.Management.Automation.SessionStateEntryVisibility]
    ${Visibility},

    [switch]
    ${Force},

    [switch]
    ${PassThru},

    [ValidateNotNullOrEmpty()]
    [string]
    ${Scope})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\New-Variable', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\New-Variable
.ForwardHelpCategory Cmdlet

#>


}

