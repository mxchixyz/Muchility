Function ChocoUpdateAll {
    # Check if Chocolatey is installed
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Host "Choco is updating all apps"
        
        # Enable global confirmation for silent updates
        choco feature enable -n allowGlobalConfirmation
        
        # Update all installed packages with Chocolatey
        choco upgrade all -force -y
    } else {
        Write-Host "Choco missing, Installing."
        
        # Install Chocolatey
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; 
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        
        Write-Host "Choco installed. Updating."
        
        # Enable global confirmation for silent updates
        choco feature enable -n allowGlobalConfirmation
        
        # Update all installed packages with Chocolatey
        choco upgrade all -force -y
    }
}
ChocoUpdateAll