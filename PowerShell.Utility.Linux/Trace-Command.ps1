Function Trace-Command {

[CmdletBinding(DefaultParameterSetName='expressionSet', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2097136')]
param(
    [Parameter(ValueFromPipeline=$true)]
    [psobject]
    ${InputObject},

    [Parameter(Mandatory=$true, Position=0)]
    [string[]]
    ${Name},

    [Parameter(Position=2)]
    [System.Management.Automation.PSTraceSourceOptions]
    ${Option},

    [Parameter(ParameterSetName='expressionSet', Mandatory=$true, Position=1)]
    [scriptblock]
    ${Expression},

    [Parameter(ParameterSetName='commandSet', Mandatory=$true, Position=1)]
    [string]
    ${Command},

    [Parameter(ParameterSetName='commandSet', ValueFromRemainingArguments=$true)]
    [Alias('Args')]
    [System.Object[]]
    ${ArgumentList},

    [System.Diagnostics.TraceOptions]
    ${ListenerOption},

    [Alias('PSPath','Path')]
    [string]
    ${FilePath},

    [switch]
    ${Force},

    [switch]
    ${Debugger},

    [switch]
    ${PSHost})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Trace-Command', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Trace-Command
.ForwardHelpCategory Cmdlet

#>


}

