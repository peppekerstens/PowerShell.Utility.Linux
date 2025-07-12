Function Import-Csv {

[CmdletBinding(DefaultParameterSetName='DelimiterPath', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2097020')]
param(
    [Parameter(ParameterSetName='DelimiterPath', Position=1)]
    [Parameter(ParameterSetName='DelimiterLiteralPath', Position=1)]
    [ValidateNotNull()]
    [char]
    ${Delimiter},

    [Parameter(ParameterSetName='DelimiterPath', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='CulturePath', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Path},

    [Parameter(ParameterSetName='DelimiterLiteralPath', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='CultureLiteralPath', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath','LP')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${LiteralPath},

    [Parameter(ParameterSetName='CulturePath', Mandatory=$true)]
    [Parameter(ParameterSetName='CultureLiteralPath', Mandatory=$true)]
    [ValidateNotNull()]
    [switch]
    ${UseCulture},

    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Header},

    [ValidateNotNullOrEmpty()]
    [System.Text.Encoding]
    ${Encoding})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Import-Csv', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Import-Csv
.ForwardHelpCategory Cmdlet

#>


}

