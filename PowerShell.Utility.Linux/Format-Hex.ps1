Function Format-Hex {

[CmdletBinding(HelpUri='https://go.microsoft.com/fwlink/?LinkId=2096611')]
param(
    [Parameter(ParameterSetName='Path', Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Path},

    [Parameter(ParameterSetName='LiteralPath', Mandatory=$true)]
    [Alias('PSPath','LP')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${LiteralPath},

    [Parameter(ParameterSetName='ByInputObject', Mandatory=$true, ValueFromPipeline=$true)]
    [psobject]
    ${InputObject},

    [Parameter(ParameterSetName='ByInputObject')]
    [ValidateNotNullOrEmpty()]
    [System.Text.Encoding]
    ${Encoding},

    [ValidateRange([System.Management.Automation.ValidateRangeKind]::Positive)]
    [long]
    ${Count},

    [ValidateRange([System.Management.Automation.ValidateRangeKind]::NonNegative)]
    [long]
    ${Offset},

    [Parameter(ParameterSetName='ByInputObject')]
    [Obsolete('Raw parameter is deprecated.', $true)]
    [switch]
    ${Raw})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Format-Hex', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Format-Hex
.ForwardHelpCategory Cmdlet

#>


}

