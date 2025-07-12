Function Add-Member {

[CmdletBinding(DefaultParameterSetName='TypeNameSet', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2097109', RemotingCapability='None')]
param(
    [Parameter(ParameterSetName='MemberSet', Mandatory=$true, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='TypeNameSet', Mandatory=$true, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='NotePropertySingleMemberSet', Mandatory=$true, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='NotePropertyMultiMemberSet', Mandatory=$true, ValueFromPipeline=$true)]
    [psobject]
    ${InputObject},

    [Parameter(ParameterSetName='MemberSet', Mandatory=$true, Position=0)]
    [Alias('Type')]
    [System.Management.Automation.PSMemberTypes]
    ${MemberType},

    [Parameter(ParameterSetName='MemberSet', Mandatory=$true, Position=1)]
    [string]
    ${Name},

    [Parameter(ParameterSetName='MemberSet', Position=2)]
    [System.Object]
    ${Value},

    [Parameter(ParameterSetName='MemberSet', Position=3)]
    [System.Object]
    ${SecondValue},

    [Parameter(ParameterSetName='TypeNameSet', Mandatory=$true)]
    [Parameter(ParameterSetName='MemberSet')]
    [Parameter(ParameterSetName='NotePropertySingleMemberSet')]
    [Parameter(ParameterSetName='NotePropertyMultiMemberSet')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${TypeName},

    [Parameter(ParameterSetName='MemberSet')]
    [Parameter(ParameterSetName='NotePropertySingleMemberSet')]
    [Parameter(ParameterSetName='NotePropertyMultiMemberSet')]
    [switch]
    ${Force},

    [Parameter(ParameterSetName='MemberSet')]
    [Parameter(ParameterSetName='TypeNameSet')]
    [Parameter(ParameterSetName='NotePropertySingleMemberSet')]
    [Parameter(ParameterSetName='NotePropertyMultiMemberSet')]
    [switch]
    ${PassThru},

    [Parameter(ParameterSetName='NotePropertySingleMemberSet', Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${NotePropertyName},

    [Parameter(ParameterSetName='NotePropertySingleMemberSet', Mandatory=$true, Position=1)]
    [AllowNull()]
    [System.Object]
    ${NotePropertyValue},

    [Parameter(ParameterSetName='NotePropertyMultiMemberSet', Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [System.Collections.IDictionary]
    ${NotePropertyMembers})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Add-Member', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Add-Member
.ForwardHelpCategory Cmdlet

#>


}

