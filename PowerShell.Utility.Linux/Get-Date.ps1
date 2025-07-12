Function Get-Date {

[CmdletBinding(DefaultParameterSetName='DateAndFormat', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096615')]
param(
    [Parameter(ParameterSetName='DateAndFormat', Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='DateAndUFormat', Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('LastWriteTime')]
    [datetime]
    ${Date},

    [Parameter(ParameterSetName='UnixTimeSecondsAndFormat', Mandatory=$true)]
    [Parameter(ParameterSetName='UnixTimeSecondsAndUFormat', Mandatory=$true)]
    [Alias('UnixTime')]
    [ValidateRange(-62135596800, 253402300799)]
    [long]
    ${UnixTimeSeconds},

    [ValidateRange(1, 9999)]
    [int]
    ${Year},

    [ValidateRange(1, 12)]
    [int]
    ${Month},

    [ValidateRange(1, 31)]
    [int]
    ${Day},

    [ValidateRange(0, 23)]
    [int]
    ${Hour},

    [ValidateRange(0, 59)]
    [int]
    ${Minute},

    [ValidateRange(0, 59)]
    [int]
    ${Second},

    [ValidateRange(0, 999)]
    [int]
    ${Millisecond},

    [Microsoft.PowerShell.Commands.DisplayHintType]
    ${DisplayHint},

    [Parameter(ParameterSetName='DateAndUFormat', Mandatory=$true)]
    [Parameter(ParameterSetName='UnixTimeSecondsAndUFormat', Mandatory=$true)]
    [string]
    ${UFormat},

    [Parameter(ParameterSetName='DateAndFormat')]
    [Parameter(ParameterSetName='UnixTimeSecondsAndFormat')]
    [string]
    ${Format},

    [switch]
    ${AsUTC})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Get-Date', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Get-Date
.ForwardHelpCategory Cmdlet

#>


}

