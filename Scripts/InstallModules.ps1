function Install-Modules() {
    if (-not (Get-Module -Name posh-alias)) { 
        Install-Module -Name posh-alias
    }

    if (-not (Get-Module -Name posh-git)) { 
        Install-Module -Name posh-git
    }

    if (-not (Get-Module -Name Terminal-Icons)) { 
        Install-Module -Name Terminal-Icons
    }

    if (-not (Get-Module -Name PSReadLine)) { 
        Install-Module -Name PowerShellGet -Force; exit
        Install-Module PSReadLine -Repository PSGallery -Scope CurrentUser -Force
    }
}