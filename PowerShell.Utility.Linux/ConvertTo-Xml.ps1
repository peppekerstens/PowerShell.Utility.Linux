Function ConvertTo-Xml {

[CmdletBinding(HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096603', RemotingCapability='None')]
param(
    [Parameter(HelpMessage='Specifies how many levels of contained objects should be included in the XML representation')]
    [ValidateRange(1, 2147483647)]
    [int]
    ${Depth},

    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [AllowNull()]
    [psobject]
    ${InputObject},

    [Parameter(HelpMessage='Specifies not to include the Type information in the XML representation')]
    [switch]
    ${NoTypeInformation},

    [ValidateNotNullOrEmpty()]
    [ValidateSet('Stream','String','Document')]
    [string]
    ${As})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\ConvertTo-Xml', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\ConvertTo-Xml
.ForwardHelpCategory Cmdlet

#>


}

