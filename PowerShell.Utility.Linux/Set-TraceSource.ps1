Function Set-TraceSource {

[CmdletBinding(DefaultParameterSetName='optionsSet', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2097129')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [string[]]
    ${Name},

    [Parameter(ParameterSetName='optionsSet', Position=1, ValueFromPipelineByPropertyName=$true)]
    [System.Management.Automation.PSTraceSourceOptions]
    ${Option},

    [Parameter(ParameterSetName='optionsSet')]
    [System.Diagnostics.TraceOptions]
    ${ListenerOption},

    [Parameter(ParameterSetName='optionsSet')]
    [Alias('PSPath','Path')]
    [string]
    ${FilePath},

    [Parameter(ParameterSetName='optionsSet')]
    [switch]
    ${Force},

    [Parameter(ParameterSetName='optionsSet')]
    [switch]
    ${Debugger},

    [Parameter(ParameterSetName='optionsSet')]
    [switch]
    ${PSHost},

    [Parameter(ParameterSetName='removeAllListenersSet')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${RemoveListener},

    [Parameter(ParameterSetName='removeFileListenersSet')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${RemoveFileListener},

    [Parameter(ParameterSetName='optionsSet')]
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

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Set-TraceSource', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Set-TraceSource
.ForwardHelpCategory Cmdlet

#>


}

