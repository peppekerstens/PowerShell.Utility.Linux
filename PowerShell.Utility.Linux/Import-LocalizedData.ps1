Function Import-LocalizedData {

[CmdletBinding(HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096710')]
param(
    [Parameter(Position=0)]
    [Alias('Variable')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${BindingVariable},

    [Parameter(Position=1)]
    [string]
    ${UICulture},

    [string]
    ${BaseDirectory},

    [string]
    ${FileName},

    [string[]]
    ${SupportedCommand})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Import-LocalizedData', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Import-LocalizedData
.ForwardHelpCategory Cmdlet

#>


}

