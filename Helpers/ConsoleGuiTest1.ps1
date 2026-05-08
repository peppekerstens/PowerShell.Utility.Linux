Import-Module Microsoft.PowerShell.ConsoleGuiTools 
$module = (Get-Module Microsoft.PowerShell.ConsoleGuiTools -List).ModuleBase
Add-Type -Path (Join-path $module Terminal.Gui.dll)
[Terminal.Gui.Application]::Init()
$Window = [Terminal.Gui.Window]::new()
$Window.Title = "Commands"
[Terminal.Gui.Application]::Top.Add($Window)

$Frame1 = [Terminal.Gui.FrameView]::new()
$Frame1.Width = [Terminal.Gui.Dim]::Percent(50)
$Frame1.Height = [Terminal.Gui.Dim]::Fill()
$Frame1.Title = "Frame 1"
$Window.Add($Frame1)

$Frame2 = [Terminal.Gui.FrameView]::new()
$Frame2.Width = [Terminal.Gui.Dim]::Percent(50)
$Frame2.Height = [Terminal.Gui.Dim]::Fill()
$Frame2.X = [Terminal.Gui.Pos]::Right($Frame1)
$Frame2.Title = "Frame 2"
$Window.Add($Frame2)


$Label1 = [Terminal.Gui.Label]::new()
$Label1.Text = "Frame 1 Content"
$Label1.Height = 1
$Label1.Width = 20
$Frame1.Add($Label1)

$Label2 = [Terminal.Gui.Label]::new()
$Label2.Text = "Frame 2 Content"
$Label2.Height = 1
$Label2.Width = 20
$Frame2.Add($Label2)

$Button = [Terminal.Gui.Button]::new()
$Button.Text = "Button" 
$Button.Clicked.Add({
    [Terminal.Gui.MessageBox]::Query("Button Clicked", "You clicked the button!", "OK")
})
$Frame1.Add($Button)

#Set-up fialog for command parameters
$Dialog = [Terminal.Gui.Dialog]::new()
$Dialog.Title = "Whoa"
$Textfield = [Terminal.Gui.Textfield]::new()
$Textfield.Width = 10
$Dialog.Add($Textfield)

[Terminal.Gui.Application]::Run()
#$Window.Add($Dialog)
#[Terminal.Gui.Application]::Run($Dialog)
#start-sleep 10
#[Terminal.Gui.Application]::Shutdown($Dialog)

start-sleep 5

#[Terminal.Gui.Application]::Shutdown()

[Terminal.Gui.Application]::Exit(0)
[Terminal.Gui.Application]::Cleanup()