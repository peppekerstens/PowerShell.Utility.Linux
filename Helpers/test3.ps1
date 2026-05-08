# This file was generated at 7/15/2025 9:15:50 PM
# Manually editing this file may result in issues with the designer
$Window = [Terminal.Gui.FrameView]::new()
$Window.Id = 'Window'
$Window.Title = 'Window'
$Window.X = 0
$Window.Y = 0
$Window.Width = [Terminal.Gui.Dim]::Fill()
$Window.Height = [Terminal.Gui.Dim]::Fill()
$ = [Terminal.Gui.Button]::new()
$.Text = ''
$.IsDefault = $False
$.HotKey = 'Null'
$.AutoSize = $False
$.Shortcut = 'Null'
$.TabIndex = 0
$.TabStop = $True
$.CanFocus = $True
$.Id = ''
$.WantMousePositionReports = $False
$.WantContinuousButtonPressed = $False
$.LayoutStyle = 'Computed'
$.X = [Terminal.Gui.Pos]::At(0)
$.Y = [Terminal.Gui.Pos]::At(0)
$.Width = [Terminal.Gui.Dim]::Sized(4)
$.Height = [Terminal.Gui.Dim]::Sized(1)
$.TextAlignment = 'Centered'
$.VerticalTextAlignment = 'Top'
$.TextDirection = 'LeftRight_TopBottom'
$.IsInitialized = $True
$.Enabled = $True
$.Visible = $False
$Window.Add($)
$Window
