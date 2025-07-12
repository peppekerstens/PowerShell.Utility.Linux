Function Import-PowerShellDataFile {

[CmdletBinding(DefaultParameterSetName='ByPath', HelpUri='https://go.microsoft.com/fwlink/?LinkID=623621', RemotingCapability='None')]
param(
    [Parameter(ParameterSetName='ByPath', Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Path},

    [Parameter(ParameterSetName='ByLiteralPath', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath','LP')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${LiteralPath},

    [switch]
    ${SkipLimitCheck})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Import-PowerShellDataFile', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Import-PowerShellDataFile
.ForwardHelpCategory Cmdlet

#>


}

