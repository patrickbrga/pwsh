Import-Module Terminal-Icons -DisableNameChecking
Import-Module PSReadLine -DisableNameChecking
Import-Module posh-git -DisableNameChecking


$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
. "$root/Profiles/Functions.ps1"
. "$root/CreateAliases.ps1"

$WarningPreference = "SilentlyContinue"

Set-PSReadLineOption -HistorySearchCursorMovesToEnd

Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadLineOption -ShowToolTips
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -HistoryNoDuplicates:$True

#Set the color for Prediction (auto-suggestion)
Set-PSReadlineOption -Colors @{
  Command = '#F4d412'
  InlinePrediction = '#FFAAFF'
}

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\my_custom_theme.omp.json" | Invoke-Expression
