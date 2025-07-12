Function Set-MarkdownOption {

[CmdletBinding(DefaultParameterSetName='IndividualSetting', HelpUri='https://go.microsoft.com/fwlink/?linkid=2006265')]
param(
    [Parameter(ParameterSetName='IndividualSetting')]
    [ValidatePattern('^\[*[0-9;]*?m{1}')]
    [string]
    ${Header1Color},

    [Parameter(ParameterSetName='IndividualSetting')]
    [ValidatePattern('^\[*[0-9;]*?m{1}')]
    [string]
    ${Header2Color},

    [Parameter(ParameterSetName='IndividualSetting')]
    [ValidatePattern('^\[*[0-9;]*?m{1}')]
    [string]
    ${Header3Color},

    [Parameter(ParameterSetName='IndividualSetting')]
    [ValidatePattern('^\[*[0-9;]*?m{1}')]
    [string]
    ${Header4Color},

    [Parameter(ParameterSetName='IndividualSetting')]
    [ValidatePattern('^\[*[0-9;]*?m{1}')]
    [string]
    ${Header5Color},

    [Parameter(ParameterSetName='IndividualSetting')]
    [ValidatePattern('^\[*[0-9;]*?m{1}')]
    [string]
    ${Header6Color},

    [Parameter(ParameterSetName='IndividualSetting')]
    [ValidatePattern('^\[*[0-9;]*?m{1}')]
    [string]
    ${Code},

    [Parameter(ParameterSetName='IndividualSetting')]
    [ValidatePattern('^\[*[0-9;]*?m{1}')]
    [string]
    ${ImageAltTextForegroundColor},

    [Parameter(ParameterSetName='IndividualSetting')]
    [ValidatePattern('^\[*[0-9;]*?m{1}')]
    [string]
    ${LinkForegroundColor},

    [Parameter(ParameterSetName='IndividualSetting')]
    [ValidatePattern('^\[*[0-9;]*?m{1}')]
    [string]
    ${ItalicsForegroundColor},

    [Parameter(ParameterSetName='IndividualSetting')]
    [ValidatePattern('^\[*[0-9;]*?m{1}')]
    [string]
    ${BoldForegroundColor},

    [switch]
    ${PassThru},

    [Parameter(ParameterSetName='Theme', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [ValidateSet('Dark','Light')]
    [string]
    ${Theme},

    [Parameter(ParameterSetName='InputObject', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [psobject]
    ${InputObject})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Set-MarkdownOption', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Set-MarkdownOption
.ForwardHelpCategory Cmdlet

#>


}

