Function ConvertTo-Json {

[CmdletBinding(HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096925', RemotingCapability='None')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [AllowNull()]
    [System.Object]
    ${InputObject},

    [ValidateRange(0, 100)]
    [int]
    ${Depth},

    [switch]
    ${Compress},

    [switch]
    ${EnumsAsStrings},

    [switch]
    ${AsArray},

    [Newtonsoft.Json.StringEscapeHandling]
    ${EscapeHandling})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\ConvertTo-Json', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\ConvertTo-Json
.ForwardHelpCategory Cmdlet

#>


}

