# PowerShell.Utility.Linux

PowerShell module for Linux aiming cmdlet to represent missing commands from Microsoft.PowerShell.Utility

This is work in progress. More information can be found [here](https://peppekerstens.github.io/linux-command-wrapping-part-1/)

## Context

Some metadata for context and reference:

```powershell
#linux box
$psversionTable

Name                           Value
----                           -----
PSVersion                      7.5.1
PSEdition                      Core
GitCommitId                    7.5.1
OS                             Ubuntu 24.04.2 LTS
Platform                       Unix
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0…}
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1
WSManStackVersion              3.0

get-module  microsoft.powershell.utility -listavailable

    Directory: /opt/microsoft/powershell/7/Modules

ModuleType Version    PreRelease Name                                PSEdition ExportedCommands
---------- -------    ---------- ----                                --------- ----------------
Manifest   7.0.0.0               Microsoft.PowerShell.Utility        Core      {Export-Alias, Get-Alias, Impor…
```


```powershell
#windows box
$PSversionTable

Name                           Value
----                           -----
PSVersion                      7.5.1
PSEdition                      Core
GitCommitId                    7.5.1
OS                             Microsoft Windows 10.0.26100
Platform                       Win32NT
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0…}
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1
WSManStackVersion              3.0

get-module  microsoft.powershell.utility -listavailable

    Directory: C:\program files\powershell\7\Modules

ModuleType Version    PreRelease Name                                PSEdition ExportedCommands
---------- -------    ---------- ----                                --------- ----------------
Manifest   7.0.0.0               Microsoft.PowerShell.Utility        Core      {Export-Alias, Get-Alias, Import-Alias,…
```

## Missing commands

After installing PowerShell on Linux, the Microsoft.PowerShell.Utility does exist. However, not all cmdlets, present in Windows are there.

```powershell
#linux box
Get-Command -module  microsoft.powershell.utility | Select name | Export-Csv ./utility-linux.csv
```

```powershell
#windows box
Get-Command -module  microsoft.powershell.utility | Select name | Export-Csv ./utility-windows.csv
```

```powershell
#comparing

$tuxutil = import-csv ./utility-linux.csv
$winutil = import-csv ./utility-windows.csv

compare-object -ReferenceObject $winutil -DifferenceObject $tuxutil -property name

name                   SideIndicator
----                   -------------
ConvertFrom-SddlString =>
Out-GridView           =>
Out-Printer            =>
Show-Command           =>
```

## Populating

First the module has been populated via the helper function initialise-module in [helper.ps1](./Helpers/helper.ps1). These create proxy functions like so:

```powershell
#windows box
. ./helpers/helper.ps1
Initialize-Module -Module Microsoft.PowerShell.Utility -Path ./PowerShell.Utility.Linux
```

Then every command, which is not in the list above, was manually deleted. 