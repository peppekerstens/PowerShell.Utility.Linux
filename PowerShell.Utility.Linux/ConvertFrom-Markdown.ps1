Function ConvertFrom-Markdown {

[CmdletBinding(DefaultParameterSetName='PathParamSet', HelpUri='https://go.microsoft.com/fwlink/?linkid=2006503')]
param(
    [Parameter(ParameterSetName='PathParamSet', Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Path},

    [Parameter(ParameterSetName='LiteralParamSet', Mandatory=$true)]
    [Alias('PSPath','LP')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${LiteralPath},

    [Parameter(ParameterSetName='InputObjParamSet', Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [psobject]
    ${InputObject},

    [switch]
    ${AsVT100EncodedString})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\ConvertFrom-Markdown', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\ConvertFrom-Markdown
.ForwardHelpCategory Cmdlet

#>


}

