Function Test-Json {

[CmdletBinding(DefaultParameterSetName='JsonString', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096609')]
param(
    [Parameter(ParameterSetName='JsonString', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='JsonStringWithSchemaString', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='JsonStringWithSchemaFile', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [string]
    ${Json},

    [Parameter(ParameterSetName='JsonPath', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='JsonPathWithSchemaString', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='JsonPathWithSchemaFile', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [string]
    ${Path},

    [Parameter(ParameterSetName='JsonLiteralPath', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='JsonLiteralPathWithSchemaString', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='JsonLiteralPathWithSchemaFile', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath','LP')]
    [string]
    ${LiteralPath},

    [Parameter(ParameterSetName='JsonStringWithSchemaString', Mandatory=$true, Position=1)]
    [Parameter(ParameterSetName='JsonPathWithSchemaString', Mandatory=$true, Position=1)]
    [Parameter(ParameterSetName='JsonLiteralPathWithSchemaString', Mandatory=$true, Position=1)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Schema},

    [Parameter(ParameterSetName='JsonStringWithSchemaFile', Mandatory=$true, Position=1)]
    [Parameter(ParameterSetName='JsonPathWithSchemaFile', Mandatory=$true, Position=1)]
    [Parameter(ParameterSetName='JsonLiteralPathWithSchemaFile', Mandatory=$true, Position=1)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${SchemaFile},

    [ValidateNotNullOrEmpty()]
    [ValidateSet('IgnoreComments','AllowTrailingCommas')]
    [string[]]
    ${Options})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Test-Json', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Test-Json
.ForwardHelpCategory Cmdlet

#>


}

