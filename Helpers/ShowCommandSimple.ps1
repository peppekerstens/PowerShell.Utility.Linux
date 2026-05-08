Import-Module Microsoft.PowerShell.ConsoleGuiTools

# Get available commands
$commands = Get-Command | Where-Object { $_.CommandType -eq 'Cmdlet' -or $_.CommandType -eq 'Function' }
$commandNames = $commands | Select-Object -ExpandProperty Name

# Select a command using Out-ConsoleGridView
$selectedCmd = $commandNames | Out-ConsoleGridView -Title 'Select a command to show parameters' -OutputMode Single
if (-not $selectedCmd) { return }

# Get parameter sets
$selectedCmd = Get-Command -Name $selectedCmd
$parameterSets = @()
$parameterSets += $selectedCmd.ParameterSets
if ($parameterSets.count -gt 1) {
    $selectedParameterSet = $parameterSets.Name | Out-ConsoleGridView -Title 'Select a Parameter Set' -OutputMode Single
    if (-not $selectedParameterSet) { return }
} else {
    $selectedParameterSet = $parameterSets[0].Name
}

# Strip the common parameters from the parameter set
enum commonParameters{
    Debug
    ErrorAction
    ErrorVariable
    InformationAction    
    InformationVariable
    OutVariable
    OutBuffer
    PipelineVariable
    ProgressAction
    Verbose
    WarningAction
    WarningVariable
}
$selectedParameterSet = $selectedCmd.ParameterSets | Where-Object { $_.Name -eq $selectedParameterSet }
$actualParameters = $selectedParameterSet.Parameters.Where{$_.Name -notin [commonParameters].GetEnumNames()}

# Get parameter info
$paramInfo = $actualParameters | ForEach-Object {
    [PSCustomObject]@{
        Name = $_.Name
        Type = $_.ParameterType.Name
        IsMandatory = $_.IsMandatory
        DefaultValue = $_.DefaultValue
    }
}

# Prepare input form for parameters
$formFields = $paramInfo | ForEach-Object {
    [PSCustomObject]@{
        Parameter = $_.Name
        Value = $_.DefaultValue
    }
}

# Show parameter input grid
$inputParams = $formFields | Out-ConsoleGridView -Title "Enter parameter values for $selectedCmd (edit Value column)" -OutputMode Multiple
if (-not $inputParams) { return }

# Build command line
$paramString = $inputParams | Where-Object { $_.Value -ne $null -and $_.Value -ne '' } | ForEach-Object {
    "-$_($._.Parameter) $_($._.Value)"
} | Join-String ' '

$finalCommand = "$selectedCmd $paramString"

# Show final command and offer to run
Write-Host "Command to run: $finalCommand" -ForegroundColor Cyan
$run = Read-Host 'Run this command? (y/n)'
if ($run -eq 'y') {
    Invoke-Expression $finalCommand
}
