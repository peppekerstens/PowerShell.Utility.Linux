Function Remove-TypeData {

[CmdletBinding(DefaultParameterSetName='RemoveTypeDataSet', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096622')]
param(
    [Parameter(ParameterSetName='RemoveTypeSet', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${TypeName},

    [Parameter(ParameterSetName='RemoveFileSet', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Path},

    [Parameter(ParameterSetName='RemoveTypeDataSet', Mandatory=$true, ValueFromPipeline=$true)]
    [System.Management.Automation.Runspaces.TypeData]
    ${TypeData})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Remove-TypeData', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Remove-TypeData
.ForwardHelpCategory Cmdlet

#>


}

