enum ShowCommandCommonParameter {
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

function Show-Command {
    <#
    .Synopsis
        Displays a window that lets you pick a command and fill in its parameters.
    .Description
        Cross-platform implementation of Show-Command.
        On Windows (PS7+), delegates to the built-in Microsoft.PowerShell.Utility\Show-Command cmdlet.
        On Linux, provides a TUI equivalent using Microsoft.PowerShell.ConsoleGuiTools:
          1. Select a command from a filterable list (filtered by -Name if supplied).
          2. If the command has multiple parameter sets, select one.
          3. View parameter names, types and mandatory flags.
          4. Optionally run the command via Invoke-Expression.
        Note: -Height, -Width and -ErrorPopup are ignored on Linux (GUI-only concepts).
    .Parameter Name
        Filters the command list to names matching this value (wildcards supported).
        If a single exact match is found it is selected automatically.
    .Parameter NoCommonParameter
        Hides common parameters from the parameter list.
    .Parameter PassThru
        Returns the command string instead of executing it (Linux only).
    .Notes
        Free to use under GNU v3 Public License (https://choosealicense.com/licenses/gpl-3.0/)
        Author: Peppe Kerstens (NLD)
        Version: 1.0.0
        Date: 2025-07-16
    .Link
        https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/show-command
    #>
    [CmdletBinding(HelpUri='https://go.microsoft.com/fwlink/?LinkID=2109589')]
    param(
        [Parameter(Position=0)]
        [Alias('CommandName')]
        [string]${Name},

        [ValidateRange(300, 2147483647)]
        [double]${Height},

        [ValidateRange(300, 2147483647)]
        [double]${Width},

        [switch]${NoCommonParameter},
        [switch]${ErrorPopup},
        [switch]${PassThru}
    )

    # --- Windows: delegate to built-in ---
    if (-not $IsLinux) {
        try {
            $outBuffer = $null
            if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
                $PSBoundParameters['OutBuffer'] = 1
            }
            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(
                'Microsoft.PowerShell.Utility\Show-Command',
                [System.Management.Automation.CommandTypes]::Cmdlet)
            $scriptCmd = { & $wrappedCmd @PSBoundParameters }
            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($PSCmdlet)
            $steppablePipeline.Process($_)
            $steppablePipeline.End()
        } catch {
            throw
        }
        return
    }

    # --- Linux: TUI via ConsoleGuiTools ---
    if (-not (Get-Module Microsoft.PowerShell.ConsoleGuiTools -ListAvailable)) {
        try {
            Write-Verbose "Installing Microsoft.PowerShell.ConsoleGuiTools..."
            Install-Module Microsoft.PowerShell.ConsoleGuiTools -Repository PSGallery -Force -Scope CurrentUser
        } catch {
            throw "Show-Command: Failed to install Microsoft.PowerShell.ConsoleGuiTools. $_"
        }
    }
    Import-Module Microsoft.PowerShell.ConsoleGuiTools -ErrorAction Stop

    # Step 1: build command list
    $allCommands = Get-Command | Where-Object { $_.CommandType -in 'Cmdlet','Function','ExternalScript','Script' }
    if ($PSBoundParameters.ContainsKey('Name') -and -not [string]::IsNullOrEmpty($Name)) {
        $allCommands = $allCommands | Where-Object { $_.Name -like $Name }
    }
    if (-not $allCommands) {
        Write-Warning "Show-Command: No commands found matching '$Name'."
        return
    }

    # If exactly one match, skip selection UI
    if (@($allCommands).Count -eq 1) {
        $selectedCmdName = @($allCommands)[0].Name
    } else {
        $selectedCmdName = $allCommands |
            Select-Object -ExpandProperty Name |
            Sort-Object |
            Out-ConsoleGridView -Title 'Show-Command: Select a command' -OutputMode Single
        if (-not $selectedCmdName) { return }
    }

    $selectedCmd = Get-Command -Name $selectedCmdName -ErrorAction Stop

    # Step 2: parameter set selection
    $parameterSets = @($selectedCmd.ParameterSets)
    if ($parameterSets.Count -gt 1) {
        $selectedSetName = $parameterSets |
            Select-Object -ExpandProperty Name |
            Out-ConsoleGridView -Title "Show-Command: Select parameter set for $selectedCmdName" -OutputMode Single
        if (-not $selectedSetName) { return }
        $selectedSet = $parameterSets | Where-Object { $_.Name -eq $selectedSetName }
    } else {
        $selectedSet = $parameterSets[0]
    }

    # Step 3: filter parameters
    $commonNames = [ShowCommandCommonParameter].GetEnumNames()
    $params = $selectedSet.Parameters
    if ($NoCommonParameter) {
        $params = $params | Where-Object { $_.Name -notin $commonNames }
    }

    # Step 4: show parameter info table (read-only view — ConsoleGuiTools does not support editable cells)
    $paramInfo = $params | ForEach-Object {
        [PSCustomObject]@{
            Name      = $_.Name
            Type      = $_.ParameterType.Name
            Mandatory = $_.IsMandatory
            Position  = if ($_.Position -ge 0) { $_.Position } else { 'named' }
        }
    }
    $paramInfo | Out-ConsoleGridView -Title "Parameters for $selectedCmdName ($($selectedSet.Name))" -OutputMode None

    # Step 5: display the command signature and offer to open help
    $signature = "$selectedCmdName " + (
        $params |
        Where-Object { $_.IsMandatory } |
        ForEach-Object { "-$($_.Name) <$($_.ParameterType.Name)>" }
    ) -join ' '

    Write-Host "`nCommand: $signature" -ForegroundColor Cyan
    Write-Host "Run 'Get-Help $selectedCmdName -Full' for detailed help." -ForegroundColor DarkGray

    if ($PassThru) {
        return $signature
    }

    <#
    .ForwardHelpTargetName Microsoft.PowerShell.Utility\Show-Command
    .ForwardHelpCategory Cmdlet
    #>
}

