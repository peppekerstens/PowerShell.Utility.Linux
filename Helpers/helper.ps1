function New-ProxyFunction{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Name
    )
    
    #source: https://devblogs.microsoft.com/scripting/proxy-functions-spice-up-your-powershell-core-cmdlets/
    $MetaData = New-Object System.Management.Automation.CommandMetaData (Get-Command  $Name) 
    return [System.Management.Automation.ProxyCommand]::Create($MetaData)
}
function Initialize-Module{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Name
        ,
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    
    $module = Get-Module -Name $Name -ListAvailable
    if ($null -eq $module) {
        Write-Error "Module '$Name' not found."
        return
    }
    
    $functions = Get-Command -Module $Name | Where-Object { $_.CommandType -eq 'Function' -or $_.CommandType -eq 'Cmdlet' }
    
    foreach ($function in $functions) {
        $scriptBlock = Join-Path -Path $Path -ChildPath "$($function.Name).ps1"
        if (-Not (Test-Path -Path $scriptBlock)) {
            New-Item -Path $scriptBlock -ItemType File -Force | Out-Null
        }
        # Write the proxy function to the script file
        "Function $($function.Name) {`n" | Set-Content -Path $scriptBlock
        New-ProxyFunction -Name $function.Name | Add-Content -Path $scriptBlock
        "`n}`n" | Add-Content -Path $scriptBlock
    }
}

