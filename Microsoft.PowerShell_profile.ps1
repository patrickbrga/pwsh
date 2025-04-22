$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

. "$root/ImportModule.ps1"
. "$root/Functions.ps1"
. "$root/CreateAliases.ps1"

$WarningPreference = "SilentlyContinue"

. "$root/Configs/PSReadLine.ps1"

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\my_custom_theme.omp.json" | Invoke-Expression