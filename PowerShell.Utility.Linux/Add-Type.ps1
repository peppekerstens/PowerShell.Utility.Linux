Function Add-Type {

[CmdletBinding(DefaultParameterSetName='FromSource', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096601')]
param(
    [Parameter(ParameterSetName='FromSource', Mandatory=$true, Position=0)]
    [string]
    ${TypeDefinition},

    [Parameter(ParameterSetName='FromMember', Mandatory=$true, Position=0)]
    [string]
    ${Name},

    [Parameter(ParameterSetName='FromMember', Mandatory=$true, Position=1)]
    [string[]]
    ${MemberDefinition},

    [Parameter(ParameterSetName='FromMember')]
    [Alias('NS')]
    [AllowNull()]
    [string]
    ${Namespace},

    [Parameter(ParameterSetName='FromMember')]
    [Alias('Using')]
    [ValidateNotNull()]
    [string[]]
    ${UsingNamespace},

    [Parameter(ParameterSetName='FromPath', Mandatory=$true, Position=0)]
    [string[]]
    ${Path},

    [Parameter(ParameterSetName='FromLiteralPath', Mandatory=$true)]
    [Alias('PSPath','LP')]
    [string[]]
    ${LiteralPath},

    [Parameter(ParameterSetName='FromAssemblyName', Mandatory=$true)]
    [Alias('AN')]
    [string[]]
    ${AssemblyName},

    [Parameter(ParameterSetName='FromSource')]
    [Parameter(ParameterSetName='FromMember')]
    [Microsoft.PowerShell.Commands.Language]
    ${Language},

    [Parameter(ParameterSetName='FromSource')]
    [Parameter(ParameterSetName='FromMember')]
    [Parameter(ParameterSetName='FromPath')]
    [Parameter(ParameterSetName='FromLiteralPath')]
    [Alias('RA')]
    [string[]]
    ${ReferencedAssemblies},

    [Parameter(ParameterSetName='FromSource')]
    [Parameter(ParameterSetName='FromMember')]
    [Parameter(ParameterSetName='FromPath')]
    [Parameter(ParameterSetName='FromLiteralPath')]
    [Alias('OA')]
    [string]
    ${OutputAssembly},

    [Parameter(ParameterSetName='FromSource')]
    [Parameter(ParameterSetName='FromMember')]
    [Parameter(ParameterSetName='FromPath')]
    [Parameter(ParameterSetName='FromLiteralPath')]
    [Alias('OT')]
    [Microsoft.PowerShell.Commands.OutputAssemblyType]
    ${OutputType},

    [switch]
    ${PassThru},

    [Parameter(ParameterSetName='FromSource')]
    [Parameter(ParameterSetName='FromMember')]
    [Parameter(ParameterSetName='FromPath')]
    [Parameter(ParameterSetName='FromLiteralPath')]
    [switch]
    ${IgnoreWarnings},

    [Parameter(ParameterSetName='FromSource')]
    [Parameter(ParameterSetName='FromMember')]
    [Parameter(ParameterSetName='FromPath')]
    [Parameter(ParameterSetName='FromLiteralPath')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${CompilerOptions})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Add-Type', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Add-Type
.ForwardHelpCategory Cmdlet

#>


}

