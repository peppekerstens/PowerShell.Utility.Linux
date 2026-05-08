# This file was generated at 7/15/2025 9:01:57 PM
# Manually editing this file may result in issues with the designer
$Window = [Terminal.Gui.FrameView]::new()
$Window.Id = 'Window'
$Window.Title = 'Window'
$Window.X = 0
$Window.Y = 0
$Window.Width = [Terminal.Gui.Dim]::Fill()
$Window.Height = [Terminal.Gui.Dim]::Fill()
$btnQuit = [Terminal.Gui.Button]::new()
$btnQuit.Text = 'Quit'
$btnQuit.IsDefault = $False
$btnQuit.HotKey = 'Q'
$btnQuit.AutoSize = $False
$btnQuit.Shortcut = 'Null'
$btnQuit.TabIndex = 1
$btnQuit.TabStop = $True
$btnQuit.CanFocus = $True
$btnQuit.Id = 'btnQuit'
$btnQuit.WantMousePositionReports = $False
$btnQuit.WantContinuousButtonPressed = $False
$btnQuit.LayoutStyle = 'Computed'
$btnQuit.X = [Terminal.Gui.Pos]::Bottom($Window)
$btnQuit.Y = [Terminal.Gui.Pos]::At(0)
$btnQuit.Width = [Terminal.Gui.Dim]::Sized(10)
$btnQuit.Height = [Terminal.Gui.Dim]::Sized(1)
$btnQuit.TextAlignment = 'Centered'
$btnQuit.VerticalTextAlignment = 'Top'
$btnQuit.TextDirection = 'LeftRight_TopBottom'
$btnQuit.IsInitialized = $True
$btnQuit.Enabled = $True
$btnQuit.Visible = $True
$Window.Add($btnQuit)
$btnCopy = [Terminal.Gui.Button]::new()
$btnCopy.Text = 'Copy'
$btnCopy.IsDefault = $False
$btnCopy.HotKey = 'C'
$btnCopy.AutoSize = $False
$btnCopy.Shortcut = 'Null'
$btnCopy.TabIndex = 2
$btnCopy.TabStop = $True
$btnCopy.CanFocus = $True
$btnCopy.Id = 'btnCopy'
$btnCopy.WantMousePositionReports = $False
$btnCopy.WantContinuousButtonPressed = $False
$btnCopy.LayoutStyle = 'Computed'
$btnCopy.X = [Terminal.Gui.Pos]::At(0)
$btnCopy.Y = [Terminal.Gui.Pos]::At(0)
$btnCopy.Width = [Terminal.Gui.Dim]::Sized(10)
$btnCopy.Height = [Terminal.Gui.Dim]::Sized(1)
$btnCopy.TextAlignment = 'Left'
$btnCopy.VerticalTextAlignment = 'Top'
$btnCopy.TextDirection = 'LeftRight_TopBottom'
$btnCopy.IsInitialized = $True
$btnCopy.Enabled = $True
$btnCopy.Visible = $True
$Window.Add($btnCopy)
$frmModules = [Terminal.Gui.FrameView]::new()
$frmModules.Title = 'Modules'
$frmModules.Border = Terminal.Gui.Border
$frmModules.Text = ''
$frmModules.TextAlignment = 'Left'
$frmModules.HotKey = 'Null'
$frmModules.Shortcut = 'Null'
$frmModules.TabIndex = -1
$frmModules.TabStop = $False
$frmModules.CanFocus = $False
$frmModules.Id = 'frmModules'
$frmModules.WantMousePositionReports = $False
$frmModules.WantContinuousButtonPressed = $False
$frmModules.LayoutStyle = 'Computed'
$frmModules.X = [Terminal.Gui.Pos]::At(0)
$frmModules.Y = [Terminal.Gui.Pos]::At(0)
$frmModules.Width = [Terminal.Gui.Dim]::Fill()
$frmModules.Height = [Terminal.Gui.Dim]::Sized(5)
$frmModules.AutoSize = $False
$frmModules.VerticalTextAlignment = 'Top'
$frmModules.TextDirection = 'LeftRight_TopBottom'
$frmModules.IsInitialized = $True
$frmModules.Enabled = $True
$frmModules.Visible = $True
$Window.Add($frmModules)
$View1 = [Terminal.Gui.FrameView]::new()
$View1.Title = 'FrameView'
$View1.Border = Terminal.Gui.Border
$View1.Text = ''
$View1.TextAlignment = 'Left'
$View1.HotKey = 'Null'
$View1.Shortcut = 'Null'
$View1.TabIndex = -1
$View1.TabStop = $False
$View1.CanFocus = $False
$View1.Id = 'View1'
$View1.WantMousePositionReports = $False
$View1.WantContinuousButtonPressed = $False
$View1.LayoutStyle = 'Computed'
$View1.X = [Terminal.Gui.Pos]::At(0)
$View1.Y = [Terminal.Gui.Pos]::At(0)
$View1.Width = [Terminal.Gui.Dim]::Sized(25)
$View1.Height = [Terminal.Gui.Dim]::Sized(5)
$View1.AutoSize = $False
$View1.VerticalTextAlignment = 'Top'
$View1.TextDirection = 'LeftRight_TopBottom'
$View1.IsInitialized = $True
$View1.Enabled = $True
$View1.Visible = $True
$Window.Add($View1)
$lstModules = [Terminal.Gui.ListView]::new()
$lstModules.AllowsMarking = $False
$lstModules.AllowsMultipleSelection = $True
$lstModules.TopItem = 0
$lstModules.LeftItem = 0
$lstModules.SelectedItem = 0
$lstModules.HotKey = 'M'
$lstModules.Shortcut = 'Null'
$lstModules.TabIndex = 3
$lstModules.TabStop = $True
$lstModules.CanFocus = $True
$lstModules.Id = 'lstModules'
$lstModules.WantMousePositionReports = $False
$lstModules.WantContinuousButtonPressed = $False
$lstModules.LayoutStyle = 'Computed'
$lstModules.X = [Terminal.Gui.Pos]::At(0)
$lstModules.Y = [Terminal.Gui.Pos]::At(0)
$lstModules.Width = [Terminal.Gui.Dim]::Sized(0)
$lstModules.Height = [Terminal.Gui.Dim]::Sized(0)
$lstModules.Text = ''
$lstModules.AutoSize = $False
$lstModules.TextAlignment = 'Left'
$lstModules.VerticalTextAlignment = 'Top'
$lstModules.TextDirection = 'LeftRight_TopBottom'
$lstModules.IsInitialized = $True
$lstModules.Enabled = $True
$lstModules.Visible = $True
$Window.Add($lstModules)
# List available commands
$commands = Get-Command | Where-Object { $_.CommandType -eq 'Cmdlet' } | Select-Object -ExpandProperty Name
$lstModules.SetSource($commands)

# Add parameter view
$frmParams = [Terminal.Gui.FrameView]::new()
$frmParams.Title = 'Parameters'
$frmParams.X = [Terminal.Gui.Pos]::At(26)
$frmParams.Y = [Terminal.Gui.Pos]::At(0)
$frmParams.Width = [Terminal.Gui.Dim]::Fill()
$frmParams.Height = [Terminal.Gui.Dim]::Sized(10)
$Window.Add($frmParams)

# Add output view
$txtOutput = [Terminal.Gui.TextView]::new()
$txtOutput.X = [Terminal.Gui.Pos]::At(0)
$txtOutput.Y = [Terminal.Gui.Pos]::At(11)
$txtOutput.Width = [Terminal.Gui.Dim]::Fill()
$txtOutput.Height = [Terminal.Gui.Dim]::Fill()
$Window.Add($txtOutput)

# Store parameter controls
$paramControls = @{}

# When a command is selected, show its parameters
$lstModules.add_SelectedItemChanged({
    $frmParams.RemoveAll()
    $paramControls.Clear()
    $selectedCmd = $commands[$lstModules.SelectedItem]
    $params = (Get-Command $selectedCmd).Parameters.Keys
    $y = 0
    foreach ($param in $params) {
        $lbl = [Terminal.Gui.Label]::new()
        $lbl.Text = $param
        $lbl.X = [Terminal.Gui.Pos]::At(0)
        $lbl.Y = [Terminal.Gui.Pos]::At($y)
        $lbl.Width = [Terminal.Gui.Dim]::Sized(20)
        $frmParams.Add($lbl)
        $txt = [Terminal.Gui.TextField]::new()
        $txt.X = [Terminal.Gui.Pos]::At(21)
        $txt.Y = [Terminal.Gui.Pos]::At($y)
        $txt.Width = [Terminal.Gui.Dim]::Sized(30)
        $frmParams.Add($txt)
        $paramControls[$param] = $txt
        $y++
    }
})

# Run button
$btnRun = [Terminal.Gui.Button]::new()
$btnRun.Text = 'Run'
$btnRun.X = [Terminal.Gui.Pos]::At(0)
$btnRun.Y = [Terminal.Gui.Pos]::At(10)
$btnRun.Width = [Terminal.Gui.Dim]::Sized(10)
$frmParams.Add($btnRun)

$btnRun.add_Clicked({
    $selectedCmd = $commands[$lstModules.SelectedItem]
    $paramStr = ''
    foreach ($param in $paramControls.Keys) {
        $val = $paramControls[$param].Text
        if ($val -ne '') {
            $paramStr += " -$param '$val'"
        }
    }
    $script = "$selectedCmd$paramStr"
    try {
        $result = Invoke-Expression $script | Out-String
        $txtOutput.Text = $result
    } catch {
        $txtOutput.Text = $_.Exception.Message
    }
})
$Window
