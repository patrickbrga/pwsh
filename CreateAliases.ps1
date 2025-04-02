function add {
    if ($args) {
        Invoke-Expression ( "git add " + ($args -join ' ') )
    } else {
        git add -A :/
    }
}

Add-Alias vso 'Invoke-Item ./**/*.sln'
Add-Alias path '(Get-Location).Path'
Add-Alias prj-lets 'cd ~\git\lets'

Add-Alias st 'git status'
Add-Alias push 'git push'
Add-Alias pull 'git pull'
Add-Alias log 'git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
Add-Alias ci 'git commit'
Add-Alias ck 'git checkout'
Add-Alias dif 'git diff'
Add-Alias rs 'git reset'
Add-Alias rb 'git rebase'
Add-Alias fixup 'git fixup'
Add-Alias branch 'git branch'
Add-Alias tag 'git tag'
Add-Alias up 'git up'
Add-Alias sync 'git fetch --prune tags ; git pull'

Add-Alias pub 'bash publish_branch.sh'

function ll () { Get-ChildItem | Format-Wide -Column 1 }

if (Get-Command curl -CommandType Application -ErrorAction Ignore) {
    #use system curl if available
    if (Get-Alias curl -ErrorAction Ignore) {
        Remove-Item alias:curl
    }
}

function pushup() {
    $branch = $(git rev-parse --abbrev-ref HEAD)
    git push --set-upstream origin $branch
}

function kns($namespace) {
    kubectl config set-context $(kubectl config current-context) --namespace=$namespace
} 

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
    git branch | %{ $_.Trim() } | ?{ $_ -ne 'master' } | ?{ $_ -ne 'main'} | ?{ $_ -ne 'develop'} | ?{ $_ -ne 'develop-intdev'} | ?{ $_ -inotmatch 'feat'} | %{ git branch -D $_ }
}

function clearproj() {
    Get-ChildItem .\ -include bin,obj -Recurse | foreach ($_) { remove-item $_.fullname -Force -Recurse }
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