Add-Alias vso 'Invoke-Item (Get-ChildItem -Path . -Recurse -Filter *.sln | Select-Object -First 1)'
Add-Alias path '(Get-Location).Path'

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
Add-Alias sync 'git fetch --prune --tags ; git pull'

Add-Alias pub 'bash publish_branch.sh'

(Get-ChildItem -Path ~/git).Name | %{ Add-Alias "prj-$_" "cd ~/git/$_" }

function add {
    if ($args) {
        Invoke-Expression ( "git add " + ($args -join ' ') )
    } else {
        git add -A :/
    }
}

function pushup() {
    $branch = $(git rev-parse --abbrev-ref HEAD)
    git push --set-upstream origin $branch
}