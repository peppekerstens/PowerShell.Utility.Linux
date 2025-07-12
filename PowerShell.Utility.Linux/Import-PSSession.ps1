Function Import-PSSession {

[CmdletBinding(HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096712')]
param(
    [ValidateNotNullOrEmpty()]
    [string]
    ${Prefix},

    [switch]
    ${DisableNameChecking},

    [Parameter(Position=2)]
    [Alias('Name')]
    [string[]]
    ${CommandName},

    [switch]
    ${AllowClobber},

    [Alias('Args')]
    [AllowNull()]
    [AllowEmptyCollection()]
    [System.Object[]]
    ${ArgumentList},

    [Alias('Type')]
    [System.Management.Automation.CommandTypes]
    ${CommandType},

    [Alias('PSSnapin')]
    [ValidateNotNull()]
    [string[]]
    ${Module},

    [ValidateNotNull()]
    [Microsoft.PowerShell.Commands.ModuleSpecification[]]
    ${FullyQualifiedModule},

    [Parameter(Position=3)]
    [string[]]
    ${FormatTypeName},

    [System.Security.Cryptography.X509Certificates.X509Certificate2]
    ${Certificate},

    [Parameter(Mandatory=$true, Position=0)]
    [ValidateNotNull()]
    [System.Management.Automation.Runspaces.PSSession]
    ${Session})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Import-PSSession', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Import-PSSession
.ForwardHelpCategory Cmdlet

#>


}

