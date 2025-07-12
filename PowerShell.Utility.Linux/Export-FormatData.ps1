Function Export-FormatData {

[CmdletBinding(DefaultParameterSetName='ByPath', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096834')]
param(
    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [System.Management.Automation.ExtendedTypeDefinition[]]
    ${InputObject},

    [Parameter(ParameterSetName='ByPath', Mandatory=$true)]
    [Alias('FilePath')]
    [string]
    ${Path},

    [Parameter(ParameterSetName='ByLiteralPath', Mandatory=$true)]
    [Alias('PSPath','LP')]
    [string]
    ${LiteralPath},

    [switch]
    ${Force},

    [Alias('NoOverwrite')]
    [switch]
    ${NoClobber},

    [switch]
    ${IncludeScriptBlock})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Export-FormatData', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Export-FormatData
.ForwardHelpCategory Cmdlet

#>


}

