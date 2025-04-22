function ll () { Get-ChildItem | Format-Wide -Column 1 }

function watch($command)
{
    Write-Host 'Update every 1s'

    $origpos = $host.UI.RawUI.CursorPosition
    $origpos.Y += 1;

    while(1) {
        $host.UI.RawUI.CursorPosition = $origpos

        iex $command;

        Start-Sleep -Milliseconds 1000;
    }
}

function git-clear-fix() {
    git branch | %{ $_.Trim() } 
        | ?{ $_ -ne 'master' } 
        | ?{ $_ -ne 'main'} 
        | ?{ $_ -ne 'develop'} 
        | ?{ $_ -ne 'develop-intdev'} 
        | ?{ $_ -inotmatch 'feat'} 
        | %{ git branch -D $_ }
}

function clearproj() {
    Get-ChildItem .\ -include bin,obj -Recurse | foreach ($_) { Remove-Item $_.fullname -Force -Recurse }
}

function report-generate() {
    $testProj = (Get-Item .).Name.Replace("Api", "Domain.Test")
    $testProj = ".\src\${testProj}\${testProj}.csproj"

    dotnet build $testProj

    dotnet test $testProj --results-directory .\.dotCover --no-build --collect 'XPlat Code Coverage;Format=opencover' --settings '.\src\CodeCoverage.runsettings' 
        | ?{ $_ -match 'xml'}
        | %{ reportgenerator -reports:$_.Trim() -targetdir:'OpenCover' -reporttypes:'Html' }

    Invoke-Expression '.\OpenCover\index.html'
}

function Remove-HistoryDuplicates {
  $HASH = @{}
  Get-Content (Get-PSReadlineOption).HistorySavePath | ` 
    ForEach-Object {
      if ( $HASH.$_ -eq $null ) { $_ }
      $HASH.$_ = 1 } > $env:TMP\PowerShell-History
  Copy-Item $env:TMP\PowerShell-History (Get-PSReadlineOption).HistorySavePath
}