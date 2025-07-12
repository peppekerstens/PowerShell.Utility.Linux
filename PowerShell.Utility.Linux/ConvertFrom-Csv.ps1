Function ConvertFrom-Csv {

[CmdletBinding(DefaultParameterSetName='Delimiter', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096830', RemotingCapability='None')]
param(
    [Parameter(ParameterSetName='Delimiter', Position=1)]
    [ValidateNotNull()]
    [ValidateNotNullOrEmpty()]
    [char]
    ${Delimiter},

    [Parameter(ParameterSetName='UseCulture', Mandatory=$true)]
    [ValidateNotNull()]
    [ValidateNotNullOrEmpty()]
    [switch]
    ${UseCulture},

    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [ValidateNotNullOrEmpty()]
    [psobject[]]
    ${InputObject},

    [ValidateNotNull()]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Header})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\ConvertFrom-Csv', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\ConvertFrom-Csv
.ForwardHelpCategory Cmdlet

#>


}

