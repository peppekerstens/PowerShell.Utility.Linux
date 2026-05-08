Import-Module Microsoft.PowerShell.ConsoleGuiTools 
$module = (Get-Module Microsoft.PowerShell.ConsoleGuiTools -List).ModuleBase
Add-Type -Path (Join-path $module Terminal.Gui.dll)
[Terminal.Gui.Application]::Init()
$Window = [Terminal.Gui.Window]::new()
$Window.Title = "Commands"
[Terminal.Gui.Application]::Top.Add($Window)

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


[Terminal.Gui.Application]::Run()