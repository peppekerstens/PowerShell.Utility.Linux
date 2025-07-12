Function Send-MailMessage {

[CmdletBinding(HelpUri='https://go.microsoft.com/fwlink/?LinkID=2097115')]
param(
    [Parameter(ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('PsPath')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Attachments},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Bcc},

    [Parameter(Position=2, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Body},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Alias('BAH')]
    [switch]
    ${BodyAsHtml},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Alias('BE')]
    [ValidateNotNullOrEmpty()]
    [System.Text.Encoding]
    ${Encoding},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Cc},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Alias('DNO')]
    [ValidateNotNullOrEmpty()]
    [System.Net.Mail.DeliveryNotificationOptions]
    ${DeliveryNotificationOption},

    [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${From},

    [Parameter(Position=3, ValueFromPipelineByPropertyName=$true)]
    [Alias('ComputerName')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${SmtpServer},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [System.Net.Mail.MailPriority]
    ${Priority},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string[]]
    ${ReplyTo},

    [Parameter(Position=1, ValueFromPipelineByPropertyName=$true)]
    [Alias('sub')]
    [string]
    ${Subject},

    [Parameter(Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${To},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${UseSsl},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(0, 2147483647)]
    [int]
    ${Port})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }

        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Send-MailMessage', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Send-MailMessage
.ForwardHelpCategory Cmdlet

#>


}

