# PowerShell.Utility.Linux

PowerShell 7.x module providing cmdlet parity with `Microsoft.PowerShell.Utility` on Linux. Implements the four cmdlets that are present on Windows but missing from the Linux build of PowerShell 7.

Part of the **Linux PowerShell Cmdlet Parity** project — inspired by Evgenij Smirnov's [2025 European PowerShell Summit session](https://www.youtube.com/watch?v=RlzinWYIjBY) and documented in the blog series at [peppekerstens.github.io](https://peppekerstens.github.io/linux-command-wrapping-part-1/).

---

## What it does

On **Linux**, provides fully functional replacements using `Microsoft.PowerShell.ConsoleGuiTools` (TUI) and native Linux tools (`lp`/CUPS).

On **Windows**, every function delegates transparently to the built-in `Microsoft.PowerShell.Utility` cmdlet — no behavioral change.

---

## Requirements

- PowerShell 7.2+
- Linux: CUPS (`lp`) for `Out-Printer`; `Microsoft.PowerShell.ConsoleGuiTools` for `Out-GridView` and `Show-Command` (auto-installed on first use if missing)

---

## Installation

```powershell
# Clone or copy the module folder to a PSModulePath location, then:
Import-Module PowerShell.Utility.Linux
```

---

## Usage

```powershell
# Interactive grid view (replaces Out-GridView on Linux)
Get-Process | Out-GridView

# Select a single item and return it
$proc = Get-Process | Out-GridView -OutputMode Single -PassThru

# Print a file
Get-Content report.txt | Out-Printer

# Browse available commands interactively
Show-Command

# Convert an SDDL string to a readable object
ConvertFrom-SddlString 'O:BAG:SYD:...'
```

---

## Cmdlet Status

Legend: ✅ Implemented &nbsp;|&nbsp; ⚠️ Stub &nbsp;|&nbsp; ➖ N/A on Linux

| Cmdlet | Status | Linux implementation | Notes |
|---|:---:|---|---|
| `Out-GridView` | ✅ | `Microsoft.PowerShell.ConsoleGuiTools` (`Out-ConsoleGridView`) | Full TUI grid; `-OutputMode`, `-PassThru`, `-Title` supported |
| `Out-Printer` | ✅ | `lp` (CUPS) via temp file | `-Name` selects printer; checks `lp` availability |
| `Show-Command` | ✅ | `Out-ConsoleGridView` for command/parameter-set selection | Parameter metadata displayed; value entry not supported (ConsoleGuiTools limitation) |
| `ConvertFrom-SddlString` | ⚠️ | Stub — SDDL is Windows-specific | Emits a warning on Linux; returns object with `RawDescriptor` |

### Not included (already work in PS7 on Linux)

All other `Microsoft.PowerShell.Utility` cmdlets (`Export-Csv`, `ConvertTo-Json`, `Select-Object`, `Sort-Object`, etc.) work natively in PowerShell 7 on Linux — no wrapping needed.

---

## Implementation notes

- `ConsoleGuiTools` is installed on demand inside `Out-GridView` and `Show-Command` to avoid hard dependency errors on platforms where the module is not present.
- `Out-ConsoleGridView` does not support editable cells — full parameter value-entry for `Show-Command` would require a custom TUI form (e.g. via PSTuiTools, which uses Terminal.Gui v1.19). This is noted as a future enhancement.
- `Out-Printer` writes pipeline input to a temp file and passes it to `lp`. The temp file is cleaned up after printing.

---

## Version history

| Version | Notes |
|---|---|
| 0.4.0 | Fix `psm1` loading test files (replaced `-Exclude` with `Where-Object`). Fix `ConvertFrom-SddlString`: now a Linux-aware stub (emits warning, returns `RawDescriptor`). Add `Examples\` folder: 4 scripts + `Examples.Tests.ps1` (20 tests pass WSL2). |
| 0.3.0 | `Out-Printer`: full Linux implementation via `lp`/CUPS. `Show-Command`: TUI implementation via `Out-ConsoleGridView` on Linux, Windows fallback retained. Module manifest (`.psd1`) and root module (`.psm1`) added. |
| 0.2.0 | `Out-GridView`: cross-platform implementation via `Out-ConsoleGridView`. |
| 0.1.0 | Initial scaffolding. |

---

## License

GPL-3.0 — see [LICENSE](LICENSE).
