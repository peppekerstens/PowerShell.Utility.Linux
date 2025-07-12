Function Update-FormatData {

[CmdletBinding(DefaultParameterSetName='FileSet', SupportsShouldProcess=$true, ConfirmImpact='Low', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2097135')]
param(
    [Parameter(ParameterSetName='FileSet', Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath','Path')]
    [ValidateNotNull()]
    [string[]]
    ${AppendPath},

    [Parameter(ParameterSetName='FileSet')]
    [ValidateNotNull()]
    [string[]]
    ${PrependPath})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Update-FormatData', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Update-FormatData
.ForwardHelpCategory Cmdlet

#>


}

