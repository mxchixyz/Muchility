Function Check-Winget {
    # Check if winget is installed
    return Get-Command winget -ErrorAction SilentlyContinue
}

Function Install-Winget {
    Write-Host "Winget missing, opening Microsoft Store for installation."
    Start-Process "ms-windows-store://pdp/?productid=9NBLGGH4NNS1"  # Opens the App Installer page in the Microsoft Store
}

Function Update-AllPackages {
    Write-Host "Updating all Winget packages..."
    winget upgrade --all --silent --accept-source-agreements --accept-package-agreements
}

Function WingetUpdateAll {
    # Check if Winget is installed
    if (Check-Winget) {
        Write-Host "Winget is updating all apps"
    } else {
        Install-Winget
    }

    Update-AllPackages
}

WingetUpdateAll
