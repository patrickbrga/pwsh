$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

. "$root/Scripts/InstallModules.ps1"
. "$root/ImportModule.ps1"
. "$root/Functions.ps1"
. "$root/Company.Functions.ps1"
. "$root/CreateAliases.ps1"

$WarningPreference = "SilentlyContinue"

. "$root/Configs/PSReadLine.ps1"

## "$env:POSH_THEMES_PATH\my_custom_theme.omp.json"
if ($env:TERMINAL_TYPE -eq "vscode") {
    oh-my-posh init pwsh --config "$root/Themes/cleared_theme.json" | Invoke-Expression
} else {
    oh-my-posh init pwsh --config "$root/Themes/posh_theme.json" | Invoke-Expression
}