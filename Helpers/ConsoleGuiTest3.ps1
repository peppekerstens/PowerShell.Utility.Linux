Import-Module Microsoft.PowerShell.ConsoleGuiTools 
$module = (Get-Module Microsoft.PowerShell.ConsoleGuiTools -List).ModuleBase
Add-Type -Path (Join-path $module Terminal.Gui.dll)
[Terminal.Gui.Application]::Init()
$Window = [Terminal.Gui.Window]::new()
$Window.Title = "Commands"
[Terminal.Gui.Application]::Top.Add($Window)

# Get available commands
$commands = Get-Command | Where-Object { $_.CommandType -eq 'Cmdlet' -or $_.CommandType -eq 'Function' }
$moduleNames = $commands | Where-Object { $_.ModuleName } | Select-Object -ExpandProperty ModuleName -Unique
$commandNames = $commands | Select-Object -ExpandProperty Name

# Add the Module label
$moduleLabel = [Terminal.Gui.Label]::new('Module:')
$moduleLabel.X = [Terminal.Gui.Pos]::At(0)
$moduleLabel.Y = [Terminal.Gui.Pos]::Top($Window) + 1
$Window.Add($moduleLabel)

# Add the name search option
$moduleSearchBox = [Terminal.Gui.TextField]::new()
$moduleSearchBox.X = [Terminal.Gui.Pos]::At(10)
$moduleSearchBox.Y = [Terminal.Gui.Pos]::Top($Window) + 1
$moduleSearchBox.Width = [Terminal.Gui.Dim]::Fill() - 10
$moduleSearchBox.Height = 1
#$moduleSearchBox.Text = 'Search commands...'
$moduleSearchBox.add_TextChanged({
    $searchText = $moduleSearchBox.Text.ToString()
    if ($searchText) {
        $filteredModules = $moduleNames | Where-Object { $_ -like "*$searchText*" }
        $modListView.SetSource($filteredModules)
    } else {
        $modListView.SetSource($moduleNames)
    }
})
$Window.Add($moduleSearchBox)


<#
# Add the module selection button
$selectModuleBtn = [Terminal.Gui.Button]::new('Module')
$selectModuleBtn.Text = 'Module'
$selectModuleBtn.Width = 8
$selectModuleBtn.Height = 1
#$selectModuleBtn.HotKey = M #[Terminal.Gui.Key]::Q
$selectModuleBtn.X = [Terminal.Gui.Pos]::At(0)
$selectModuleBtn.Y = [Terminal.Gui.Pos]::Top($Window) + 1
$selectModuleBtn.add_Clicked({
    #[Terminal.Gui.MessageBox]::Query("Clicked!", "")
    [Terminal.Gui.Application]::RequestStop()
})
$Window.Add($selectModuleBtn)


# Add a dropdown for module selection
$moduleDropdown = [Terminal.Gui.ComboBox]::new($moduleNames)
$moduleDropdown.X = [Terminal.Gui.Pos]::At(10)
$moduleDropdown.Y = [Terminal.Gui.Pos]::Top($Window) + 1
$moduleDropdown.Width = [Terminal.Gui.Dim]::Fill() - 10
$moduleDropdown.Height = 1
$Window.Add($moduleDropdown)
#>

# Add the name label
$nameLabel = [Terminal.Gui.Label]::new('Name:')
$nameLabel.X = [Terminal.Gui.Pos]::At(0)
$nameLabel.Y = [Terminal.Gui.Pos]::Top($Window) + 3
$Window.Add($nameLabel)

# Add the name search option
$nameSearchBox = [Terminal.Gui.TextField]::new()
$nameSearchBox.X = [Terminal.Gui.Pos]::At(10)
$nameSearchBox.Y = [Terminal.Gui.Pos]::Top($Window) + 3
$nameSearchBox.Width = [Terminal.Gui.Dim]::Fill() - 10
$nameSearchBox.Height = 1
#$nameSearchBox.Text = 'Search commands...'
$nameSearchBox.add_TextChanged({
    $searchText = $nameSearchBox.Text.ToString()
    if ($searchText) {
        $filteredCommands = $commandNames | Where-Object { $_ -like "*$searchText*" }
        $cmdListView.SetSource($filteredCommands)
    } else {
        $cmdListView.SetSource($commandNames)
    }
})
$Window.Add($nameSearchBox)

# Create ListView for modules
$modListView = [Terminal.Gui.ListView]::new($moduleNames)
$modListView.Width = [Terminal.Gui.Dim]::Fill()
$modListView.Height = 7
$modListView.X =  [Terminal.Gui.Pos]::At(12)
$modListView.Y = [Terminal.Gui.Pos]::Top($Window) + 5
$modListView.Border = [Terminal.Gui.Border]::Single
$Window.Add($modListView)

# Create ListView for commands
$cmdListView = [Terminal.Gui.ListView]::new($commandNames)
$cmdListView.Width = [Terminal.Gui.Dim]::Fill()
$cmdListView.Height = 12
$cmdListView.Y = 12
$cmdListView.X = [Terminal.Gui.Pos]::At(0)
$cmdListView.Border = [Terminal.Gui.Border]::Single
$Window.Add($cmdListView)

# Create a frame for parameters
$paramFrame = [Terminal.Gui.FrameView]::new('Parameters')
$paramFrame.X = 0
$paramFrame.Y = 12
$paramFrame.Width = [Terminal.Gui.Dim]::Fill()
$paramFrame.Height = 10
#$Window.Add($paramFrame)

# Create a dictionary to hold parameter values
$paramInputs = @{}

# Add a dropdown for module selection
<#
$moduleDropdown.add_SelectedItemChanged({
    $selectedModule = $moduleNames[$moduleDropdown.SelectedItem]
    $filteredCommands = $commands | Where-Object { $_.ModuleName -eq $selectedModule } | Select-Object -ExpandProperty Name
    $cmdListView.SetSource($filteredCommands)
})#>

# When a command is selected, show its parameters
$cmdListView.add_SelectedItemChanged({
    $selectedIdx = $cmdListView.SelectedItem
    $selectedCmd = $commandNames[$selectedIdx]
    $cmd = Get-Command -Name $selectedCmd
    $paramFrame.RemoveAll()
    $paramInputs.Clear()
    $y = 0
    foreach ($param in $cmd.Parameters.Keys) {
        $label = [Terminal.Gui.Label]::new($param)
        $label.X = 0
        $label.Y = $y
        $paramFrame.Add($label)
        $textField = [Terminal.Gui.TextField]::new('')
        $textField.X = 20
        $textField.Y = $y
        $textField.Width = 30
        $paramFrame.Add($textField)
        $paramInputs[$param] = $textField
        $y++
    }
})

# Add a button to build and show the command
$runBtn = [Terminal.Gui.Button]::new('Show Command')
$runBtn.X = 0
$runBtn.Y = [Terminal.Gui.Pos]::Bottom($paramFrame)
$runBtn.add_Clicked({
    $selectedIdx = $cmdListView.SelectedItem
    if ($selectedIdx -eq $null) { return }
    $selectedCmd = $commandNames[$selectedIdx]
    $cmdLine = $selectedCmd
    foreach ($param in $paramInputs.Keys) {
        $val = $paramInputs[$param].Text.ToString()
        if ($val -ne '') {
            $cmdLine += " -$param '$val'"
        }
    }
    [Terminal.Gui.MessageBox]::Query('Command', $cmdLine, 'OK')
})
$Window.Add($runBtn)

# Add a quit button at the right bottom
$quitBtn = [Terminal.Gui.Button]::new('Quit')
$quitBtn.X = [Terminal.Gui.Pos]::AnchorEnd(10)
$quitBtn.Y = [Terminal.Gui.Pos]::Bottom($Window) - 5
$quitBtn.add_Clicked({
    #[Terminal.Gui.MessageBox]::Query("Clicked!", "")
    [Terminal.Gui.Application]::RequestStop()
})
$Window.Add($quitBtn)


#$Button = [Terminal.Gui.Button]::new()
#$Button.Text = "Click Me"
#$Button.add_Clicked({ [Terminal.Gui.MessageBox]::Query("Clicked!", "") })
#$Window.Add($Button)

[Terminal.Gui.Application]::Run()
[Terminal.Gui.Application]::ShutDown()
