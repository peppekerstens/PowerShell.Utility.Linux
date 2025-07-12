Function Update-TypeData {

[CmdletBinding(DefaultParameterSetName='FileSet', SupportsShouldProcess=$true, ConfirmImpact='Low', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2097131')]
param(
    [Parameter(ParameterSetName='DynamicTypeSet')]
    [ValidateNotNullOrEmpty()]
    [ValidateSet('NoteProperty','AliasProperty','ScriptProperty','CodeProperty','ScriptMethod','CodeMethod')]
    [System.Management.Automation.PSMemberTypes]
    ${MemberType},

    [Parameter(ParameterSetName='DynamicTypeSet')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${MemberName},

    [Parameter(ParameterSetName='DynamicTypeSet')]
    [System.Object]
    ${Value},

    [Parameter(ParameterSetName='DynamicTypeSet')]
    [ValidateNotNull()]
    [System.Object]
    ${SecondValue},

    [Parameter(ParameterSetName='DynamicTypeSet')]
    [ValidateNotNull()]
    [type]
    ${TypeConverter},

    [Parameter(ParameterSetName='DynamicTypeSet')]
    [ValidateNotNull()]
    [type]
    ${TypeAdapter},

    [Parameter(ParameterSetName='DynamicTypeSet')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${SerializationMethod},

    [Parameter(ParameterSetName='DynamicTypeSet')]
    [ValidateNotNull()]
    [type]
    ${TargetTypeForDeserialization},

    [Parameter(ParameterSetName='DynamicTypeSet')]
    [ValidateNotNull()]
    [ValidateRange(0, 2147483647)]
    [int]
    ${SerializationDepth},

    [Parameter(ParameterSetName='DynamicTypeSet')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${DefaultDisplayProperty},

    [Parameter(ParameterSetName='DynamicTypeSet')]
    [ValidateNotNull()]
    [System.Nullable[bool]]
    ${InheritPropertySerializationSet},

    [Parameter(ParameterSetName='DynamicTypeSet')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${StringSerializationSource},

    [Parameter(ParameterSetName='DynamicTypeSet')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${DefaultDisplayPropertySet},

    [Parameter(ParameterSetName='DynamicTypeSet')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${DefaultKeyPropertySet},

    [Parameter(ParameterSetName='DynamicTypeSet')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${PropertySerializationSet},

    [Parameter(ParameterSetName='DynamicTypeSet', Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${TypeName},

    [Parameter(ParameterSetName='DynamicTypeSet')]
    [Parameter(ParameterSetName='TypeDataSet')]
    [switch]
    ${Force},

    [Parameter(ParameterSetName='TypeDataSet', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [System.Management.Automation.Runspaces.TypeData[]]
    ${TypeData},

    [Parameter(ParameterSetName='FileSet', Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath','Path')]
    [ValidateNotNull()]
    [string[]]
    ${AppendPath},

    [Parameter(ParameterSetName='FileSet')]
    [ValidateNotNull()]
    [string[]]
    ${PrependPath})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Update-TypeData', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Update-TypeData
.ForwardHelpCategory Cmdlet

#>


}

