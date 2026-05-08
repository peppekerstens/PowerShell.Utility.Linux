Import-Module Microsoft.PowerShell.ConsoleGuiTools 
$module = (Get-Module Microsoft.PowerShell.ConsoleGuiTools -List).ModuleBase
Add-Type -Path (Join-path $module Terminal.Gui.dll)
[Terminal.Gui.Application]::Init()

# Create main window
$Window = [Terminal.Gui.Window]::new()
$Window.Title = "PowerShell ISE (Terminal.Gui)"
[Terminal.Gui.Application]::Top.Add($Window)

# Script editor (TextView)
$editor = [Terminal.Gui.TextView]::new()
$editor.X = 0
$editor.Y = 1
$editor.Width = [Terminal.Gui.Dim]::Fill()
$editor.Height = [Terminal.Gui.Dim]::Fill() - 8
$editor.Text = "# Write your PowerShell script here..."
$Window.Add($editor)

# Output panel (TextView)
$outputFrame = [Terminal.Gui.FrameView]::new('Output')
$outputFrame.X = 0
$outputFrame.Y = [Terminal.Gui.Pos]::Bottom($editor)
$outputFrame.Width = [Terminal.Gui.Dim]::Fill()
$outputFrame.Height = 7
$outputBox = [Terminal.Gui.TextView]::new()
$outputBox.Width = [Terminal.Gui.Dim]::Fill()
$outputBox.Height = [Terminal.Gui.Dim]::Fill()
$outputFrame.Add($outputBox)
$Window.Add($outputFrame)

# Run button
$runBtn = [Terminal.Gui.Button]::new('Run')
$runBtn.X = 0
$runBtn.Y = 0
$runBtn.Add_Clicked({
    $script = $editor.Text
    try {
        $result = Invoke-Expression $script 2>&1 | Out-String
        $outputBox.Text = $result
    } catch {
        $outputBox.Text = $_.Exception.Message
    }
})
$Window.Add($runBtn)

# Open button
$openBtn = [Terminal.Gui.Button]::new('Open')
$openBtn.X = 10
$openBtn.Y = 0
$openBtn.Add_Clicked({
    $ofd = [Terminal.Gui.OpenDialog]::new()
    $ofd.Title = 'Open Script'
    $ofd.CanChooseFiles = $true
    $ofd.CanChooseDirectories = $false
    [Terminal.Gui.Application]::Run($ofd)
    if ($ofd.FilePaths.Count -gt 0) {
        $path = $ofd.FilePaths[0]
        $editor.Text = Get-Content $path -Raw
    }
})
$Window.Add($openBtn)

# Save button
$saveBtn = [Terminal.Gui.Button]::new('Save')
$saveBtn.X = 20
$saveBtn.Y = 0
$saveBtn.Add_Clicked({
    $sfd = [Terminal.Gui.SaveDialog]::new()
    $sfd.Title = 'Save Script'
    [Terminal.Gui.Application]::Run($sfd)
    if ($sfd.FilePath) {
        Set-Content -Path $sfd.FilePath -Value $editor.Text
    }
})
$Window.Add($saveBtn)

# Quit button
$quitBtn = [Terminal.Gui.Button]::new('Quit')
$quitBtn.X = [Terminal.Gui.Pos]::AnchorEnd(10)
$quitBtn.Y = 0
$quitBtn.Add_Clicked({
    [Terminal.Gui.Application]::RequestStop()
})
$Window.Add($quitBtn)

[Terminal.Gui.Application]::Run()
[Terminal.Gui.Application]::ShutDown()


