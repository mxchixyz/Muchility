# Below is 1st check functions

# Function to check if winget is installed
Function cWingetStatus {
    try {
        winget --version | Out-Null
        Write-Host " Winget V2 (Windows Store > App Installer) 		Installed!" -ForegroundColor Green
    }
    catch {
        Write-Host " Winget V2 (Windows Store > App Installer) 		Missing!" -ForegroundColor Red
    }
}

# Function to check if choco is installed
Function cChocoStatus {
    try {
        choco --version | Out-Null
        Write-Host " Chocolatey (Winget Alternative) 			Installed!" -ForegroundColor Green
    }
    catch {
        Write-Host " Chocolatey (Winget Alternative) 			Missing!" -ForegroundColor Red
    }
}

# Function to check BITS service status
Function cBitsService {
    $BITS = Get-Service -Name BITS
    if ($BITS.StartType -eq 'Automatic') {
        Write-Host " Background Updates					Enabled!" -ForegroundColor Green
    }
    else {
        Write-Host " Background Updates					Disabled!" -ForegroundColor Red
    }
}

# Function to check wuauserv service status
Function cWuauservService {
    $wuauserv = Get-Service -Name wuauserv
    if ($wuauserv.StartType -eq 'Automatic') {
        Write-Host " Windows Update Service					Enabled!" -ForegroundColor Green
    }
    else {
        Write-Host " Windows Update Service					Disabled!" -ForegroundColor Red
    }
}

# Function to check internet connection
Function cInternet {
    $Host.UI.RawUI.WindowTitle = "Muchility - Checking Internet Connection"
    Clear-Host
    Write-Host "Checking internet connection..." -ForegroundColor Cyan

    try {
        # Attempt to ping a reliable host (Google DNS)
        $pingResult = Test-Connection -ComputerName "8.8.8.8" -Count 1 -Quiet
        if ($pingResult) {
            Write-Host "Connected To The Internet!" -ForegroundColor Green
			Write-Host ""
			Write-Host "Continuing.."
            Start-Sleep -Seconds 3  # 3-second pause if connected
        } else {
            Write-Host "Failed To Connect To The Internet!" -ForegroundColor Red
            Write-Host "Internet is recommended for FULL FUNCTIONALITY." -ForegroundColor Yellow
            Start-Sleep -Seconds 5  # 5-second pause if not connected
        }
    } catch {
        Write-Host "Error: Unable to check internet connection." -ForegroundColor Red
    }
}

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

cInternet


function Show-Menu {
	$Host.UI.RawUI.WindowTitle = "Muchility 6.0"
	$Host.UI.RawUI.BackgroundColor = "Black"
	Clear-Host
	Write-Host " +-------------------+" -ForegroundColor Blue
	Write-Host " |" -NoNewline -ForegroundColor Blue
	Write-Host "Muchility Main Menu" -NoNewLine
	Write-Host "|" -NoNewline -ForegroundColor Blue
	Write-Host "					Created By Muchi" -ForegroundColor Magenta
	Write-Host " +-------------------+" -ForegroundColor Blue
	
    Write-Host " 1. " -NoNewline -ForegroundColor Blue
	Write-Host "Run Tweaks" -NoNewline -ForegroundColor Cyan
	Write-Host "						Performance, Debloat, QoL, Latency" -ForegroundColor Blue
	
	Write-Host " 2. " -NoNewline -ForegroundColor Blue
	wRITE-hOST "BCD Tweaks" -NoNewline -ForegroundColor Cyan
	Write-Host "						Enable Highest Mode + Boot Settings" -ForegroundColor Blue
	
	Write-Host " 3. " -NoNewline -ForegroundColor Blue
	Write-Host "Install Choco" -NoNewline -ForegroundColor Cyan
	Write-Host "					Install Choco & Dependencies" -ForegroundColor Blue
	
	Write-Host " 4. " -NoNewline -ForegroundColor Blue
	Write-Host "Install Winget" -NoNewline -ForegroundColor Cyan
	Write-Host "					Install Winget & Dependencies" -ForegroundColor Blue
	
	Write-Host " 5. " -NoNewline -ForegroundColor Blue
	Write-Host "Update Apps" -NoNewline -ForegroundColor Cyan
	Write-Host "						Update All Available Apps" -ForegroundColor Blue
	
    Write-Host " 6. " -NoNewline -ForegroundColor Blue
	Write-Host "Install Browsers" -NoNewline -ForegroundColor Cyan
	Write-Host "					Brave, Chrome & Firefox" -ForegroundColor Blue
	
	Write-Host " 7. " -NoNewline -ForegroundColor Blue
    Write-Host "Disable" -ForegroundColor Red -NoNewline
	Write-Host " Windows Auto Update" -ForegroundColor Cyan
	
	Write-Host " 8. " -NoNewline -ForegroundColor Blue
	Write-Host "Enable"  -ForegroundColor Green -NoNewline
	Write-Host " Windows Auto Update" -ForegroundColor Cyan
	
	Write-Host " 9. " -NoNewline -ForegroundColor Blue
	Write-Host "Restore Point" -NoNewline -ForegroundColor Yellow
	Write-Host "					Create A Restore Point" -ForegroundColor Blue
	
	Write-Host " T. " -NoNewLine -ForegroundColor Blue
	Write-Host "Clear Temp Folders" -NoNewLine -ForegroundColor Cyan
	Write-Host "					Free Up Space & Delete Temporary Folders" -ForegroundColor Blue
	
	Write-Host " U. " -NoNewline -ForegroundColor Blue
	Write-Host "Uninstall Winget" -ForegroundColor Cyan
	
	Write-Host " C. " -NoNewline -ForegroundColor Blue
	Write-Host "Uninstall Choco" -ForegroundColor Cyan
	
	Write-Host " A. " -NoNewline -ForegroundColor Blue
	Write-Host "Activate Windows " -NoNewLine -ForegroundColor Cyan
	Write-Host "					HWID Activation" -ForegroundColor Blue
	
	Write-Host " D. " -NoNewline -ForegroundColor Blue
	Write-Host "Update Drivers" -NoNewline -ForegroundColor Cyan
	Write-Host "					Download & Install Drivers via SDI" -ForegroundColor Blue
	
	Write-Host " S. " -NoNewline -ForegroundColor Blue
	Write-Host "System Repair" -NoNewline -ForegroundColor Cyan
	Write-Host "					Check For Corrupted Files" -ForegroundColor Blue
	
	Write-Host " M. " -NoNewline -ForegroundColor Blue
	Write-Host "Refresh Menu" -ForegroundColor Cyan
	
    Write-Host " +-------------------------+" -ForegroundColor Blue
	Write-Host " |" -NoNewline -ForegroundColor Blue
    Write-Host "Windows Automatic Updates" -NoNewLine
	Write-Host "|"-ForegroundColor Blue
	Write-Host " +-------------------------+" -ForegroundColor Blue
    cBitsService
    cWuauservService


    Write-Host " +--------------------------+" -ForegroundColor Blue
	Write-Host " |" -NoNewline -ForegroundColor Blue
    Write-Host "Windows Installer Services" -NoNewLine
	Write-Host "|"-ForegroundColor Blue
	Write-Host " +--------------------------+" -ForegroundColor Blue
	cWingetStatus
    cChocoStatus
}

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!







# Below are all functions 1-9 & T,U,C,A,D,S,M.

#1 //////////////////////////////////////////////////////////////////////////////
Function Tweaks {

	Clear-Host
	Set-RestorePointFrequency
	Enable-RestorePoints
	Clear-Host
	
	$Host.UI.RawUI.WindowTitle = "Muchility - Create A Restore Point?"														# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	Create-RestorePoint
	Start-Sleep -Seconds 2
	
	
    # Add all tweak commands here
	
	Tweaks-Muchi-Apps
	Tweaks-Muchi-Power-Plan
	Tweaks-PS1-Assoc
	Tweaks-Take-Owner
	Tweaks-Disable-UAC
	Tweaks-Disable-Wifi-Sense
	Tweaks-Disable-Win-Ads
	Tweaks-DVR-Settings
	Tweaks-Game-Mode
	Tweaks-Misc-Tweaks
	Tweaks-Original-Context-Menu
	Tweaks-Performance-Tweaks
	Tweaks-Annoyances
	Tweaks-Sch-Tasks
	Tweaks-Delete-OneDrive
	Tweaks-KBM
	Tweaks-Services
	Tweaks-Debloat
	
	
	$Host.UI.RawUI.WindowTitle = "Muchility - Cleaning Temp Folders"													# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	Write-Host "Cleaning Temp Folders"
	Clean-TempFolders
	Start-Sleep -Seconds 1
	
	
	Write-Host "Tweaks Are Finished!..."
	Start-Sleep -Seconds 1
	
	return
	#Add new tweaks below here!!!
	
}

#2 //////////////////////////////////////////////////////////////////////////////
Function BCD-Tweaks {
	$Host.UI.RawUI.WindowTitle = "Muchility - BCD Tweaks"
	Clear-Host
    Write-Host "Configuring BCD Entries..."
    # Add BCD configuration commands here

	try {
    # Set default boot menu policy to standard
    Start-Process -FilePath "cmd.exe" -ArgumentList '/c bcdedit /set {default} bootmenupolicy standard' -Wait -NoNewWindow -ErrorAction Stop
	Clear-Host
    # Set current boot menu policy to standard
    Start-Process -FilePath "cmd.exe" -ArgumentList '/c bcdedit /set {current} bootmenupolicy standard' -Wait -NoNewWindow -ErrorAction Stop
	Clear-Host
    # Enable highest mode globally
    Start-Process -FilePath "cmd.exe" -ArgumentList '/c bcdedit /set {globalsettings} highestmode true' -Wait -NoNewWindow -ErrorAction Stop
	Clear-Host
} catch {
    Write-Host "Failed to configure boot settings. Ensure you are running as administrator." -ForegroundColor DarkRed
}
return
}

#3 //////////////////////////////////////////////////////////////////////////////
Function Install-Choco {
	$Host.UI.RawUI.WindowTitle = "Muchility - Installing Choco"
    Clear-Host
	
    # Check if Chocolatey is already installed
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Host "Choco already installed." -ForegroundColor Green
        Start-Sleep -Seconds 2
        return  # Exit the function if already installed
    }
    else {
        Write-Host "Installing Chocolatey..." -ForegroundColor Yellow
        Start-Sleep -Seconds 2
        Set-ExecutionPolicy Bypass -Scope Process -Force
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        return  # Exit the function after installation
    }
}

#4 //////////////////////////////////////////////////////////////////////////////
Function Get-Winget {
	clear-host
	$Host.UI.RawUI.WindowTitle = "Muchility - Installing Winget"
	Get-WinUtilWingetPrerequisites
	Get-WinUtilWingetLatest
	Return
}

#5 //////////////////////////////////////////////////////////////////////////////
Function Update-Apps {
    $Host.UI.RawUI.WindowTitle = "Muchility - Updating Apps"
    clear-host

    # Set the background color to black and text to white
    $Host.UI.RawUI.BackgroundColor = 'Black'
    $Host.UI.RawUI.ForegroundColor = 'White'
    clear-host  # Apply the color settings immediately

    # Check if winget is installed and perform updates
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "Winget is installed. Checking and Updating apps!"
        # Update all installed packages with winget
        winget upgrade --all --silent --accept-source-agreements --accept-package-agreements
        Start-Sleep -Seconds 2
    } else {
        Write-Host "Winget is not installed."
        Start-Sleep -Seconds 1
    }

    # Check if Chocolatey is installed and perform updates
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Host "Chocolatey is installed. Checking and Updating apps!"
        # Update all installed packages with Chocolatey
        choco upgrade all -y
        Start-Sleep -Seconds 2
    } else {
        Write-Host "Chocolatey is not installed."
        Start-Sleep -Seconds 1
    }

	VC-User-Choice
}

#6 //////////////////////////////////////////////////////////////////////////////
Function Install-Browsers {
	$Host.UI.RawUI.WindowTitle = "Muchility - Browser Selection/Installation"
    clear-host
    while ($true) {
        Write-Host "" -BackgroundColor Black -NoNewline
        Write-Host "Which browser would you like to install?            " -ForegroundColor Magenta
        Write-Host "1 - Brave" -ForegroundColor Green
        Write-Host "2 - Chrome" -ForegroundColor Blue
        Write-Host "3 - Firefox" -ForegroundColor Yellow
        Write-Host "X - Return to Main Menu" -ForegroundColor White
        Write-Host ""

        $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        
        # Check if winget is available
        $wingetAvailable = Get-Command winget -ErrorAction SilentlyContinue

        function Check-BrowserInstalled {
            param (
                [string]$processName
            )
            Get-Process -Name $processName -ErrorAction SilentlyContinue
        }

        function Install-Browser {
            param (
                [string]$browserName,
                [string]$wingetID,
                [string]$chocoID,
                [string]$installMethod,
                [bool]$forceInstall
            )

            if ($installMethod -eq "w") {
                Write-Host "Installing $browserName with winget..."
                winget install --id $wingetID --force --silent --accept-package-agreements
            } elseif ($installMethod -eq "c") {
                Write-Host "Installing $browserName with choco..."
                choco feature enable -n allowGlobalConfirmation
                choco install $chocoID -y
            } else {
                Write-Host "Invalid option. Returning to menu."
            }

            Start-Sleep -Seconds 2
        }

        switch ($key.Character) {
            "1" {
                clear-host
                $installMethod = Read-Host "Do you want to use (W)inget or (C)hoco?"
                $installMethod = $installMethod.Trim().ToLower()

                if ($installMethod -eq "w" -or $installMethod -eq "c") {
                    if (Check-BrowserInstalled -processName "brave") {
                        Write-Host "Brave is already installed. Would you like to force reinstall? (Y/N)"
                        $response = Read-Host
                        if ($response -eq "Y") {
                            Install-Browser -browserName "Brave" -wingetID "Brave.Brave" -chocoID "brave" -installMethod $installMethod -forceInstall $true
                        } else {
                            Write-Host "Skipping installation."
                            Start-Sleep -Seconds 2
                        }
                    } else {
                        Install-Browser -browserName "Brave" -wingetID "Brave.Brave" -chocoID "brave" -installMethod $installMethod -forceInstall $false
                    }
                } else {
                    Write-Host "Invalid installation method. Returning to menu."
                    Start-Sleep -Seconds 2
                }
                return
            }
            "2" {
                clear-host
                $installMethod = Read-Host "Do you want to use (W)inget or (C)hoco?"
                $installMethod = $installMethod.Trim().ToLower()

                if ($installMethod -eq "w" -or $installMethod -eq "c") {
                    if (Check-BrowserInstalled -processName "chrome") {
                        Write-Host "Chrome is already installed. Would you like to force reinstall? (Y/N)"
                        $response = Read-Host
                        if ($response -eq "Y") {
                            Install-Browser -browserName "Chrome" -wingetID "Google.Chrome" -chocoID "googlechrome" -installMethod $installMethod -forceInstall $true
                        } else {
                            Write-Host "Skipping installation."
                            Start-Sleep -Seconds 2
                        }
                    } else {
                        Install-Browser -browserName "Chrome" -wingetID "Google.Chrome" -chocoID "googlechrome" -installMethod $installMethod -forceInstall $false
                    }
                } else {
                    Write-Host "Invalid installation method. Returning to menu."
                    Start-Sleep -Seconds 2
                }
                return
            }
            "3" {
                clear-host
                $installMethod = Read-Host "Do you want to use (W)inget or (C)hoco?"
                $installMethod = $installMethod.Trim().ToLower()

                if ($installMethod -eq "w" -or $installMethod -eq "c") {
                    if (Check-BrowserInstalled -processName "firefox") {
                        Write-Host "Firefox is already installed. Would you like to force reinstall? (Y/N)"
                        $response = Read-Host
                        if ($response -eq "Y") {
                            Install-Browser -browserName "Firefox" -wingetID "Mozilla.Firefox" -chocoID "firefox" -installMethod $installMethod -forceInstall $true
                        } else {
                            Write-Host "Skipping installation."
                            Start-Sleep -Seconds 2
                        }
                    } else {
                        Install-Browser -browserName "Firefox" -wingetID "Mozilla.Firefox" -chocoID "firefox" -installMethod $installMethod -forceInstall $false
                    }
                } else {
                    Write-Host "Invalid installation method. Returning to menu."
                    Start-Sleep -Seconds 2
                }
                return
            }
            "X" {
                Start-Sleep -Seconds 2
                return
            }
            default {
                Show-BrowserMenu
            }
        }
    }
}

#7 //////////////////////////////////////////////////////////////////////////////
Function Disable-WindowsUpdate {
    Clear-Host
				Stop-Service -Name 'BITS' -ErrorAction Continue
				Stop-Service -Name 'wuauserv' -ErrorAction Continue
                Set-Service -Name 'BITS' -StartupType Disabled -ErrorAction Continue
                Set-Service -Name 'wuauserv' -StartupType Disabled -ErrorAction Continue
    return  # Return to the menu
}

#8 //////////////////////////////////////////////////////////////////////////////
Function Enable-WindowsUpdate {
    Clear-Host
                Set-Service -Name 'BITS' -StartupType Automatic -ErrorAction Continue
                Set-Service -Name 'wuauserv' -StartupType Automatic -ErrorAction Continue
				Start-Service -Name 'BITS' -ErrorAction Continue
				Start-Service -Name 'wuauserv' -ErrorAction Continue
    return  # Return to the menu
}

#9 //////////////////////////////////////////////////////////////////////////////
Function Create-RestorePoint {
    Write-Host "Create a restore point?" -NoNewLine
	Write-Host "			Highly Recommended!" -ForegroundColor Yellow
	Write-Host ""
	
	Write-Host "Y = " -NoNewLine
	Write-Host "Yes" -ForegroundColor Green
	
	Write-Host "Or press any key to exit.." -ForegroundColor DarkRed
	
	
	
	Write-Host ""
    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    if ($key -match '^[Yy]$') {
        try {
            Checkpoint-Computer -Description "Before Muchility" -RestorePointType "MODIFY_SETTINGS"
			Start-Sleep -Seconds 1
            Write-Host "Restore point 'Before Muchility' created successfully." -ForegroundColor Green
            Start-Sleep -Seconds 1
        } catch {
			Start-Sleep -Seconds 1
            Write-Host "Failed to create the restore point. Error: $($_.Exception.Message)" -ForegroundColor DarkRed
            Start-Sleep -Seconds 1
            Clear-Host
            Show-Menu
        }
    } elseif ($key -match '^[Nn]$') {
        Start-Sleep -Seconds 1
        Clear-Host
		Exit
    } else {
        Write-Host "Exiting.." -ForegroundColor DarkRed
        Start-Sleep -Seconds 1
        Clear-Host
        Exit
    }
}

#T //////////////////////////////////////////////////////////////////////////////
Function Clean-TempFolders {
    # Define the paths to the temp folders
    $windowsTemp = "C:\Windows\Temp"
    $appDataTemp = [System.Environment]::GetFolderPath('LocalApplicationData') + "\Temp"
    $customTemp1 = "C:\_temp"

    # Function to remove the folder itself, ignoring files
    function Remove-TempFolder($path) {
        if (Test-Path -Path $path) {
            Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
	clear-host
    # Clean C:\Windows\Temp
    Remove-TempFolder $windowsTemp
	clear-host
    # Clean %appdata%\Local\Temp
    Remove-TempFolder $appDataTemp
	clear-host
    # Clean C:\_temp
    Remove-TempFolder $customTemp1
	clear-host
}

#U //////////////////////////////////////////////////////////////////////////////
Function Remove-Winget {
    $Host.UI.RawUI.WindowTitle = "Muchility - Removing Winget (Advanced)"
    Clear-Host

    Write-Host "Starting the removal process..." -ForegroundColor Cyan

    # Function to remove matching packages by a keyword
    function Remove-PackagesByKeyword {
        param(
            [string]$keyword
        )

        # Find all packages matching the keyword
        $packages = Get-AppxPackage | Where-Object { $_.Name -like "*$keyword*" }

        if ($packages) {
            foreach ($package in $packages) {
                $confirmation = Read-Host "Do you want to remove $($package.Name)? (Y/N)"
                if ($confirmation -eq "Y" -or $confirmation -eq "y") {
                    try {
                        Remove-AppxPackage -Package $package.PackageFullName -ErrorAction Stop
                        Write-Host "$($package.Name) removed successfully." -ForegroundColor Green
                    } catch {
                        Write-Host "Failed to remove $($package.Name). It might be in use or require elevated permissions." -ForegroundColor DarkRed
                    }
                } else {
                    Write-Host "Skipped removal of $($package.Name)." -ForegroundColor Yellow
                }
            }
        } else {
            Write-Host "No packages found matching keyword: $keyword." -ForegroundColor Yellow
        }
    }

    # Step 1: Remove packages containing 'Microsoft.VCLibs'
    Remove-PackagesByKeyword -keyword "Microsoft.VCLibs"

    # Step 2: Remove packages containing 'Microsoft.UI.Xaml'
    Remove-PackagesByKeyword -keyword "Microsoft.UI.Xaml"

    # Step 3: Remove Winget (Microsoft.DesktopAppInstaller)
    Remove-PackagesByKeyword -keyword "Microsoft.DesktopAppInstaller"

    Write-Host "Removal process completed!" -ForegroundColor Green
    Start-Sleep -Seconds 3
}

#C //////////////////////////////////////////////////////////////////////////////
Function Remove-Choco {
	    # Delete existing Chocolatey directories if found
    $chocoDir = "C:\ProgramData\chocolatey"
    $chocoCacheDir = "C:\ProgramData\ChocolateyHttpCache"
    
    if (Test-Path -Path $chocoDir) {
        Write-Host "Deleting existing Chocolatey directory..." -ForegroundColor Red
        Remove-Item -Recurse -Force -Path $chocoDir
        Write-Host "Chocolatey directory deleted." -ForegroundColor Green
    }

    if (Test-Path -Path $chocoCacheDir) {
        Write-Host "Deleting Chocolatey HttpCache directory..." -ForegroundColor Red
        Remove-Item -Recurse -Force -Path $chocoCacheDir
        Write-Host "Chocolatey HttpCache directory deleted." -ForegroundColor Green
    }

}

#A //////////////////////////////////////////////////////////////////////////////
Function Activate-Win {
    $Host.UI.RawUI.WindowTitle = "Muchility - Getting Activation Script"
    Clear-Host
	
    # Define paths
    $url = "https://www.dropbox.com/scl/fi/u2tzx77rfji79mpqa54su/Activate.cmd?rlkey=uys7zaez0dxeu3di7znwq2zty&st=7ed9il2y&dl=1"
    $filePath = "C:\Activate-Windows\Activate.cmd"
    $shortcutPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), "Activate Windows.lnk")
    Clear-Host
	
	Write-Host "Creating Folder For Script"
    # Create directory if it doesn't exist
    If (-not (Test-Path "C:\Activate-Windows")) {
        New-Item -ItemType Directory -Path "C:\Activate-Windows"
    }
	Clear-Host

	Write-Host "Downloading Script"
    # Download the file
    Invoke-WebRequest -Uri $url -OutFile $filePath
    Clear-Host
	
	Write-Host "Creating Shortcut On Desktop"
    # Create shortcut
    $WScriptShell = New-Object -ComObject WScript.Shell
    $shortcut = $WScriptShell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $filePath
    $shortcut.Arguments = "/HWID"  # Add /HWID argument
    $shortcut.WorkingDirectory = "C:\Activate-Windows"
    $shortcut.IconLocation = "C:\Windows\System32\cmd.exe, 0"  # Icon for shortcut
    $shortcut.Save()
    Clear-Host
	
	Write-Host "Opening Script"
    # Run the shortcut as administrator
    Start-Process $shortcutPath -Verb RunAs
    Clear-Host
	
	Write-Host "Returning To Menu"
    # Pause for 3 seconds
    Start-Sleep -Seconds 3
    Return
}

#D //////////////////////////////////////////////////////////////////////////////
Function cUpdate-Drivers {
    $Host.UI.RawUI.WindowTitle = "Muchility - Updating Drivers"
    Clear-Host
    Write-Host "Starting driver updates..." -ForegroundColor Cyan
	
    # Define paths and URLs
    $sdiUrl = "https://sdi-tool.org/releases/SDI_R2408.zip"  # Replace with actual SDI URL
    $sdiPath = "C:\_SDI"
    $zipFilePath = "$env:USERPROFILE\Downloads\SDI.zip"
	
Clear-Host

    # Step 1: Ensure clean slate by deleting existing folder and zip if they exist
    Write-Host "Cleaning up old files..." -ForegroundColor Yellow
    try {
        if (Test-Path $sdiPath) { Remove-Item -Path $sdiPath -Recurse -Force }
        if (Test-Path $zipFilePath) { Remove-Item -Path $zipFilePath -Force }
        Write-Host "Old files cleaned up." -ForegroundColor Green
    } catch {
        Write-Host "Warning: Cleanup failed. Continuing anyway. $_" -ForegroundColor Yellow
    }
	
Clear-Host

    # Step 2: Download the SDI zip file
    Write-Host "Downloading Snappy Driver Installer..." -ForegroundColor Yellow
    try {
        Invoke-WebRequest -Uri $sdiUrl -OutFile $zipFilePath -UseBasicParsing
        Write-Host "Download complete." -ForegroundColor Green
    } catch {
        Write-Host "Error: Failed to download SDI zip. $_" -ForegroundColor Red
        return
    }
	
Clear-Host

    # Step 3: Extract the zip to the desired location
    Write-Host "Extracting files..." -ForegroundColor Yellow
    try {
        Expand-Archive -Path $zipFilePath -DestinationPath $sdiPath -Force
        Write-Host "Extraction complete." -ForegroundColor Green
    } catch {
        Write-Host "Error: Failed to extract the SDI zip. $_" -ForegroundColor Red
        return
    }
	
Clear-Host

    # Step 4: Delete the zip file after extraction
    try {
        Remove-Item -Path $zipFilePath -Force
        Write-Host "Zip file deleted." -ForegroundColor Green
    } catch {
        Write-Host "Warning: Failed to delete the zip file. $_" -ForegroundColor Yellow
    }
	
Clear-Host

    # Step 5: Locate the SDI_auto.bat file
    Write-Host "Searching for SDI_auto.bat..." -ForegroundColor Yellow
    try {
        $batchFile = Get-ChildItem -Path $sdiPath -Filter "SDI_auto.bat" -Recurse | Select-Object -First 1
        if (-not $batchFile) {
            Write-Host "Error: No SDI_auto.bat file found in $sdiPath!" -ForegroundColor Red
            return
        }
        Write-Host "Found SDI_auto.bat: $($batchFile.Name)" -ForegroundColor Green
    } catch {
        Write-Host "Error: Failed to search for the SDI_auto.bat file. $_" -ForegroundColor Red
        return
    }
	
Clear-Host

    # Step 6: Launch the SDI_auto.bat file
    Write-Host "Launching SDI_auto.bat..." -ForegroundColor Yellow
    try {
        Start-Process -FilePath $batchFile.FullName
        Write-Host "Updates started! Select Index Only." -ForegroundColor Green
		Start-Sleep -Seconds 10
    } catch {
        Write-Host "Error: Failed to start SDI_auto.bat. $_" -ForegroundColor Red
    }
}

#S //////////////////////////////////////////////////////////////////////////////
Function cSystem-Repairs {
	$Host.UI.RawUI.WindowTitle = "Muchility - System Repairs"
    clear-host
    Write-Host "Starting system repair tasks..." -ForegroundColor Cyan

    # DISM Scan and Repair
    Write-Host "Running DISM to check and restore system health..." -ForegroundColor Yellow
    Start-Process -FilePath "dism.exe" -ArgumentList "/Online /Cleanup-Image /ScanHealth" -Wait -NoNewWindow
    Start-Process -FilePath "dism.exe" -ArgumentList "/Online /Cleanup-Image /RestoreHealth" -Wait -NoNewWindow

    # SFC Scannow
    Write-Host "Running System File Checker (SFC)..." -ForegroundColor Yellow
    Start-Process -FilePath "sfc.exe" -ArgumentList "/scannow" -Wait -NoNewWindow

    # CHKDSK Repairs
    Write-Host "Running CHKDSK to check for disk errors..." -ForegroundColor Yellow
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c chkdsk C: /F /R /X" -Wait -NoNewWindow

    Write-Host "System repair tasks completed. Please reboot if required." -ForegroundColor Green
}

#M //////////////////////////////////////////////////////////////////////////////
Function Home {
    clear-host
    return
}

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!





# Below is Tweak Functions 

Function Tweaks-Muchi-Apps {

	$Host.UI.RawUI.WindowTitle = "Muchility - Getting Muchi Apps"															# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	Write-Host "Getting Muchi Apps"
	
	# Define variables
	$downloadUrl = "https://www.dropbox.com/scl/fi/fwtyzybdmjmluewd1unxn/Muchi-Apps.zip?rlkey=a3273eli6njmbief4jka0joan&st=c1qhffua&dl=1"
	$destinationZip = "C:\Muchi-Apps.zip"
	$extractFolder = "C:\_MuchiApps"
	$shortcutPath = "$([Environment]::GetFolderPath('Desktop'))\Muchi Apps.lnk"
	clear-host
	# Download the file
	Invoke-WebRequest -Uri $downloadUrl -OutFile $destinationZip
	clear-host
	# Extract the zip file
	Expand-Archive -Path $destinationZip -DestinationPath $extractFolder -Force
	clear-host
	# Remove the downloaded zip file
	Remove-Item $destinationZip
	clear-host
	# Create a shortcut on the desktop
	$WScriptShell = New-Object -ComObject WScript.Shell
	$shortcut = $WScriptShell.CreateShortcut($shortcutPath)
	$shortcut.TargetPath = $extractFolder
	$shortcut.Save()
}

Function Tweaks-Muchi-Power-Plan {
	$Host.UI.RawUI.WindowTitle = "Muchility - Importing & Applying Power Plan"												# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	Write-Host "Importing & Applying Power Plan"
	Start-Sleep -Seconds 1
	
	
	# Define download URL and destination path
	$downloadUrl = "https://www.dropbox.com/scl/fi/r995j2ty9danfh27fr0ni/Muchi.pow?rlkey=nwm137ybjagomyy37mz76j7s6&st=pg7b92cv&dl=1"
	$destinationPath = "C:\_temp\Muchi.pow"
	Clear-Host
	
	# Pause for 1 second
	Start-Sleep -Seconds 1

	# Create the target directory if it doesn't exist
	$targetDir = Split-Path -Path $destinationPath
if (!(Test-Path -Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force
}

	Clear-Host
	
	# Pause for 1 second
	Start-Sleep -Seconds 1

	# Download the file
	Invoke-WebRequest -Uri $downloadUrl -OutFile $destinationPath
	Clear-Host
	
	# Pause for 1 second
	Start-Sleep -Seconds 1

	# Import the power plan
	powercfg -import $destinationPath
	Clear-Host

	# Get all power schemes
	$schemes = powercfg /l

	# Find the GUID of the power scheme containing "Muchi"
	$schemeGuid = $schemes | Select-String -Pattern "Muchi" | ForEach-Object { $_.ToString().Split()[3] }

	# Set the active power scheme
if ($schemeGuid) {
    powercfg /s $schemeGuid
} else {
    Write-Host "Failed To Import Power Scheme 'Muchi'"
	Write-Host ""
	Write-Host "https://www.dropbox.com/scl/fi/r995j2ty9danfh27fr0ni/Muchi.pow?rlkey=nwm137ybjagomyy37mz76j7s6&st=pg7b92cv&dl=1"
	Write-Host ""
	Write-Host "Download & Import Manually Using Link Above, If You Wish."
	Write-Host ""
	Write-Host "Resuming In 5"
	Start-Sleep -Seconds 5
}
}

Function Tweaks-PS1-Assoc {
	$Host.UI.RawUI.WindowTitle = "Muchility - Updating Powershell Association"												# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

	# _temp for registry-based cmd assoc
	$cmdFilePath = "C:\_temp\regassoc.cmd"
	$regFilePath = "C:\_temp\Powershell_ASSOC.reg" # Path for the provided .reg file
	$tempFolderPath = "C:\_temp"
	Clear-Host
	
	# Ensure the _temp folder exists
if (-not (Test-Path $tempFolderPath)) {
    New-Item -Path "C:\" -Name "_temp" -ItemType Directory
}

	Clear-Host
	# Write the .reg content to the _temp folder
	
	$regContent = @"
Windows Registry Editor Version 5.00

; Associate .ps1 files with PowerShell
[HKEY_CLASSES_ROOT\\.ps1]
@="Microsoft.PowerShellScript.1"

; Define the PowerShell Script file type
[HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1]
@="PowerShell Script"
"EditFlags"=dword:00000000
"FriendlyTypeName"="PowerShell Script"

; Set the PowerShell icon for .ps1 files
[HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\DefaultIcon]
@="C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe,0"

; Set the default command to open .ps1 files with PowerShell
[HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell\Open\Command]
@="\"C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe\" -ExecutionPolicy Bypass -File \"%1\""
"@

$regContent | Out-File -FilePath $regFilePath -Force -Encoding ASCII
Clear-Host

	# Create the CMD script content to apply registry changes
	$cmdContent = @"
@echo off
REG IMPORT "$regFilePath"
exit
"@

	Clear-Host
	# Write the content to the CMD file
	$cmdContent | Out-File -FilePath $cmdFilePath -Force -Encoding ASCII
	Clear-Host
	
	# Run the CMD script silently in an elevated Command Prompt
	Start-Process $cmdFilePath -Verb runAs -WindowStyle Hidden
	Clear-Host
	
	# Clean up
	Start-Sleep -Seconds 2
	Remove-Item -Path $cmdFilePath -Force
	Remove-Item -Path $regFilePath -Force
	Clear-Host
	
	# Remove the _temp folder
if (Test-Path $tempFolderPath) {
    Remove-Item -Path $tempFolderPath -Recurse -Force
}

	Clear-Host
	
	# Restart Windows Explorer to apply changes
	Stop-Process -Name explorer -Force
	Start-Sleep -Seconds 1
	cmd.exe /c "start explorer.exe"


	Clear-Host
	Write-Host "Powershell Association Updated!"
	Start-Sleep -Seconds 2
}

Function Tweaks-Take-Owner {
		$Host.UI.RawUI.WindowTitle = "Muchility - Adding Take Ownership To Context Menu"										# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	clear-host
	Write-Host "Adding Take Ownership To Context Menu!"
	Start-Sleep -Seconds 2



# Define the path for the .reg file
$regFilePath = "C:\_temp\takeownership.reg"

# Create the registry content for the .reg file
$regContent = @"
Windows Registry Editor Version 5.00

    ; Adds "Take Ownership" to the Right Click Context Menu
                
    [-HKEY_CLASSES_ROOT\*\shell\TakeOwnership]
    [-HKEY_CLASSES_ROOT\*\shell\runas]
              
    [HKEY_CLASSES_ROOT\*\shell\TakeOwnership]
    @="Take Ownership"
    "Extended"=-
    "HasLUAShield"=""
    "NoWorkingDirectory"=""
    "NeverDefault"=""
              
    [HKEY_CLASSES_ROOT\*\shell\TakeOwnership\command]
    @="powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%1\\\" && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l & pause' -Verb runAs\""
    "IsolatedCommand"= "powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%1\\\" && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l & pause' -Verb runAs\""

    [HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership]
    @="Take Ownership"
    "AppliesTo"="NOT (System.ItemPathDisplay:=\"C:\\Users\" OR System.ItemPathDisplay:=\"C:\\ProgramData\" OR System.ItemPathDisplay:=\"C:\\Windows\" OR System.ItemPathDisplay:=\"C:\\Windows\\System32\" OR System.ItemPathDisplay:=\"C:\\Program Files\" OR System.ItemPathDisplay:=\"C:\\Program Files (x86)\")"
    "Extended"=-
    "HasLUAShield"=""
    "NoWorkingDirectory"=""
    "Position"="middle"
              
    [HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership\command]
    @="powershell -windowstyle hidden -command \"$Y = ($null | choice).Substring(1,1); Start-Process cmd -ArgumentList ('/c takeown /f \\\"%1\\\" /r /d ' + $Y + ' && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l /q & pause') -Verb runAs\""
    "IsolatedCommand"="powershell -windowstyle hidden -command \"$Y = ($null | choice).Substring(1,1); Start-Process cmd -ArgumentList ('/c takeown /f \\\"%1\\\" /r /d ' + $Y + ' && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l /q & pause') -Verb runAs\""
                
    [HKEY_CLASSES_ROOT\Drive\shell\runas]
    @="Take Ownership"
    "Extended"=-
    "HasLUAShield"=""
    "NoWorkingDirectory"=""
    "Position"="middle"
    "AppliesTo"="NOT (System.ItemPathDisplay:=\"C:\\\")"
              
    [HKEY_CLASSES_ROOT\Drive\shell\runas\command]
    @="cmd.exe /c takeown /f \"%1\\\" /r /d y && icacls \"%1\\\" /grant *S-1-3-4:F /t /c & Pause"
    "IsolatedCommand"="cmd.exe /c takeown /f \"%1\\\" /r /d y && icacls \"%1\\\" /grant *S-1-3-4:F /t /c & Pause"
"@


# Create the _temp folder if it doesn't exist
if (-not (Test-Path "C:\_temp")) {
    New-Item -Path "C:\" -Name "_temp" -ItemType Directory
}

# Write the content to the .reg file
$regContent | Out-File -FilePath $regFilePath -Force

# Open the .reg file silently (without showing any window) using regedit
Start-Process "regedit.exe" -ArgumentList "/s $regFilePath" -WindowStyle Hidden

# Wait for 2 seconds before removing the .reg file
Start-Sleep -Seconds 2

# Delete the .reg file after use
Remove-Item -Path $regFilePath -Force
}

Function Tweaks-Disable-UAC {
	$Host.UI.RawUI.WindowTitle = "Muchility - Disabling UAC"														# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	clear-host
	Write-Host "Disabling UAC!"
	Start-Sleep -Seconds 2


# Disable UAC
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -PropertyType DWord -Value 0 -Force
}

Function Tweaks-Disable-Wifi-Sense {
	$Host.UI.RawUI.WindowTitle = "Muchility - Disabling Wi-Fi Sense"												# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	clear-host
	Write-Host "Disabling Wi-Fi Sense!"
	Start-Sleep -Seconds 2
	
	
# Disable Wifi-Sense
New-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -PropertyType DWord -Value 0 -Force
New-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -PropertyType DWord -Value 0 -Force
}

Function Tweaks-Disable-Win-Ads {
		$Host.UI.RawUI.WindowTitle = "Muchility - Disabling Advertising"												# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	clear-host
	Write-Host "Disabling Advertising!"
	Start-Sleep -Seconds 2

# DISABLE ADVERTISING & PROMOTIONAL
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "FeatureManagementEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenOverlayEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SlideshowEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-314563Enabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContentEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 0
}

Function Tweaks-DVR-Settings {
	$Host.UI.RawUI.WindowTitle = "Muchility - Setting GameDVR Settings"												# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	clear-host
	Write-Host "Setting GameDVR Settings!"
	Start-Sleep -Seconds 2


# disable game bar
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0

# disable enable open xbox game bar using game controller
Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "UseNexusForGameBarEnabled" -Value 0

# Disable Xbox GameDVR
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -PropertyType DWord -Value 0 -Force

# other DVR settings
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AudioEncodingBitrate" -Value 1305600
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AudioCaptureEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "CustomVideoEncodingBitrate" -Value 40614400
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "CustomVideoEncodingHeight" -Value 720
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "CustomVideoEncodingWidth" -Value 1280
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "HistoricalBufferLength" -Value 30
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "HistoricalBufferLengthUnit" -Value 1
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "HistoricalCaptureEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "HistoricalCaptureOnBatteryAllowed" -Value 1
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "HistoricalCaptureOnWirelessDisplayAllowed" -Value 1
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "MaximumRecordLength" -Value ([byte[]]@(0x00, 0xD0, 0x88, 0xC3, 0x10, 0x00, 0x00, 0x00))
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VideoEncodingBitrateMode" -Value 2
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VideoEncodingResolutionMode" -Value 2
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VideoEncodingFrameRateMode" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "EchoCancellationEnabled" -Value 1
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "CursorCaptureEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VKToggleGameBar" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VKMToggleGameBar" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VKSaveHistoricalVideo" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VKMSaveHistoricalVideo" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VKToggleRecording" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VKMToggleRecording" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VKTakeScreenshot" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VKMTakeScreenshot" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VKToggleRecordingIndicator" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VKMToggleRecordingIndicator" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VKToggleMicrophoneCapture" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VKMToggleMicrophoneCapture" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VKToggleCameraCapture" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VKMToggleCameraCapture" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VKToggleBroadcast" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "VKMToggleBroadcast" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "MicrophoneCaptureEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "SystemAudioGain" -Value ([byte[]]@(0x10, 0x27, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00))
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "MicrophoneGain" -Value ([byte[]]@(0x10, 0x27, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00))
}

Function Tweaks-Game-Mode {
	$Host.UI.RawUI.WindowTitle = "Muchility - Enabling Game Mode"														# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	clear-host
	Write-Host "Enabling Game Mode!"
	Start-Sleep -Seconds 2


	# enable game mode
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AutoGameModeEnabled" -Value 1
}

Function Tweaks-Misc-Tweaks {
		$Host.UI.RawUI.WindowTitle = "Muchility - Setting Misc Tweaks"														# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	clear-host
	Write-Host "Setting Misc Tweaks!"
	Start-Sleep -Seconds 2

	# Unhide "Hub Selective Suspend Timeout"
	Set-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\0853a681-27c8-4100-a2fd-82013e970683" -Name "Attributes" -Value 2

	# Unhide "USB 3 Link Power Management"
	Set-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\d4e98f31-5ffe-4ce1-be31-1b38b384c009" -Name "Attributes" -Value 2

	# Disable Tablet Mode and set desktop mode on sign-in
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" -Name "TabletMode" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" -Name "SignInMode" -PropertyType DWord -Value 1 -Force

	# Enable Long File Paths with Up to 32,767 Characters
	New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -PropertyType DWord -Value 1 -Force

	# Set high contrast flags
	New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\HighContrast" -Name "Flags" -PropertyType String -Value "4194" -Force

	# Set sound sentry settings
	New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SoundSentry" -Name "Flags" -PropertyType String -Value "0" -Force
	New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SoundSentry" -Name "FSTextEffect" -PropertyType String -Value "0" -Force
	New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SoundSentry" -Name "TextEffect" -PropertyType String -Value "0" -Force
	New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SoundSentry" -Name "WindowsEffect" -PropertyType String -Value "0" -Force

	# Enable display full path in the title bar
	New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -PropertyType DWord -Value 1 -Force

	# Set sound communications to do nothing
	New-ItemProperty -Path "HKCU:\Software\Microsoft\Multimedia\Audio" -Name "UserDuckingPreference" -PropertyType DWord -Value 3 -Force

	# Optimize video quality on battery
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\VideoSettings" -Name "VideoQualityOnBattery" -Value 1
}

Function Tweaks-Original-Context-Menu {
	$Host.UI.RawUI.WindowTitle = "Muchility - Restoring Classic Context Menu"											# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	clear-host
	Write-Host "Restoring Classic Context Menu!"
	Start-Sleep -Seconds 2


	# Restore the classic context menu
	Set-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "" -Value ""
}

Function Tweaks-Performance-Tweaks {
	$Host.UI.RawUI.WindowTitle = "Muchility - Performance Tweaks"														# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	clear-host
	Write-Host "Performance Tweaks!"
	Start-Sleep -Seconds 2


	# Enable old NVIDIA sharpening
	New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" -Name "EnableGR535" -PropertyType DWord -Value 0 -Force

	# Disable variable refresh rate and enable optimizations for windowed games
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\DirectX\UserGpuPreferences" -Name "DirectXUserGlobalSettings" -Value "SwapEffectUpgradeEnable=1;VRROptimizeEnable=0;"

	# set appearance options to custom
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 3

	# disable animate controls and elements inside windows
	# disable fade or slide menus into view
	# disable fade or slide tooltips into view
	# disable fade out menu items after clicking
	# disable show shadows under mouse pointer
	# disable show shadows under windows
	# disable slide open combo boxes
	# disable smooth-scroll list boxes
	# enable smooth edges of screen fonts
	# 100% dpi scaling
	# disable fix scaling for apps
	# disable menu show delay
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Value 0x9012038000000000
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "FontSmoothing" -Value "2"
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "LogPixels" -Value 96
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "Win8DpiScaling" -Value 1
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "EnablePerProcessSystemDPI" -Value 0
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "0"

	# Turn on hardware accelerated GPU scheduling
	New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -PropertyType DWord -Value 2 -Force

	# Adjust for best performance of programs
	New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" -Name "Win32PrioritySeparation" -PropertyType DWord -Value 38 -Force

	# Give Multimedia Applications like Games and Video Editing a Higher Priority
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -PropertyType DWord -Value 10 -Force

	# Give Graphics Cards a Higher Priority for Gaming
	# Give the CPU a Higher Priority for Gaming
	# Give Games a higher priority in the system's scheduling
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "GPU Priority" -PropertyType DWord -Value 8 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Priority" -PropertyType DWord -Value 6 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Scheduling Category" -PropertyType String -Value "High" -Force

	# Unpark CPU cores by setting the maximum processor state
	Set-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" -Name "ValueMax" -Value 0

	# Disable power throttling
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" -Name "PowerThrottlingOff" -Value 1
}

Function Tweaks-Annoyances {
		$Host.UI.RawUI.WindowTitle = "Muchility - Disabling, Preventing & Removing Annoyances"									# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	clear-host
	Write-Host "Disabling, Preventing & Removing Annoyances!"
	Start-Sleep -Seconds 2

	# Disable Cortana
	New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -PropertyType DWord -Value 0 -Force

	# Disable Windows Copilot system-wide
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" -Name "TurnOffWindowsCopilot" -PropertyType DWord -Value 1 -Force

	# Disable OneDrive Automatic Backups
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive" -Name "KFMBlockOptIn" -PropertyType DWord -Value 1 -Force

	# Disable "Push To Install" feature
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\PushToInstall" -Name "DisablePushToInstall" -PropertyType DWord -Value 1 -Force

	# Disable Windows Consumer Features and related content
	New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableConsumerAccountStateContent" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableCloudOptimizedContent" -PropertyType DWord -Value 1 -Force

	# Disable BitLocker Auto Encryption
	New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\BitLocker" -Name "PreventDeviceEncryption" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EnhancedStorageDevices" -Name "TCGSecurityActivationDisabled" -PropertyType DWord -Value 1 -Force

	# Disable Activity History
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -PropertyType DWord -Value 0 -Force

	# Disable Location Tracking
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny" -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -PropertyType DWord -Value 0 -Force

	# Disable Telemetry
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -PropertyType DWord -Value 0 -Force

	# Disable Telemetry and Feedback Notifications
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -PropertyType DWord -Value 1 -Force

	# Disable Windows Ink Workspace
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" -Name "AllowWindowsInkWorkspace" -PropertyType DWord -Value 0 -Force

	# Disable Advertising ID for All Users
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -PropertyType DWord -Value 1 -Force

	# Disable Device Installation Settings
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -PropertyType DWord -Value 1 -Force

	# Disable storage sense
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\StorageSense" -Name "AllowStorageSenseGlobal" -PropertyType DWord -Value 0 -Force

	# Disable background apps
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsRunInBackground" -PropertyType DWord -Value 2 -Force

	# Disable widgets
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" -Name "value" -PropertyType DWord -Value 0 -Force

	# disable show me notification in the settings app
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SystemSettings\AccountNotifications" -Name "EnableAccountNotifications" -Value 0

	# disable voice activation
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" -Name "AgentActivationEnabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" -Name "AgentActivationLastUsed" -Value 0

	# disable other devices 
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" -Name "Value" -Value "Deny"

	# disable let websites show me locally relevant content by accessing my language list
	Set-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Value 1

	# disable let windows improve start and search results by tracking app launches  
	Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\EdgeUI" -Name "DisableMFUTracking" -Value 1

	# disable personal inking and typing dictionary
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Value 0

	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Value 0

	# feedback frequency never
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "PeriodInNanoSeconds" -Value "-"

	# Hide the Meet Now Button on the Taskbar
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -PropertyType DWord -Value 1 -Force

	# Remove Windows widgets from taskbar
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -PropertyType DWord -Value 0 -Force

	# Remove news and interests from Taskbar
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -PropertyType DWord -Value 0 -Force

	# Disable notify me when the clock changes
	New-ItemProperty -Path "HKCU:\Control Panel\TimeDate" -Name "DstNotification" -PropertyType DWord -Value 0 -Force

	# Disable web search in start menu
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1

	# Remove Meet Now
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoStartMenuMFUprogramsList" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoInstrumentation" -ErrorAction SilentlyContinue
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Value 1

	# Remove search from taskbar
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0

	# Disable Windows managing default printer
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Windows" -Name "LegacyDefaultPrinterMode" -Value 1

	# Disable writing with fingertip
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\TabletTip\EmbeddedInkControl" -Name "EnableInkingWithTouch" -Value 0

	# Disable notifications
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "LockScreenToastEnabled" -Value 0

	# Disable Allow Notifications to Play Sounds, Disable Notifications on Lock Screen
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" -Name "NOC_GLOBAL_SETTING_ALLOW_NOTIFICATION_SOUND" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" -Name "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" -Name "NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK" -Value 0

	# Disable specific system toast notifications
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" -Name "Enabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel" -Name "Enabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.CapabilityAccess" -Name "Enabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.StartupApp" -Name "Enabled" -Value 0

	# Disable Profile Engagement (e.g., Scoobe system setting)
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Value 0

	# Disable suggested actions
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SmartActionPlatform\SmartClipboard" -Name "Disabled" -Value 1

	# Disable Windows input experience preload
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\input" -Name "IsInputAppPreloadEnabled" -Value 0

	# Disable prelaunch of Windows apps
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Dsh" -Name "IsPrelaunchEnabled" -Value 0

	# Disable Windows Copilot
	Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot" -Name "TurnOffWindowsCopilot" -Value 1

	# Remove gallery
	Remove-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" -Name "System.IsPinnedToNameSpaceTree"

	# Remove OneDrive Setup
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "OneDriveSetup"

	# Hide the Try New Outlook Button
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\Outlook\Options\General" -Name "HideNewOutlookToggle" -Value 0

	# Disable hibernate
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power" -Name "HibernateEnabled" -Value 0

	# Disable default hibernate settings
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power" -Name "HibernateEnabledDefault" -Value 0

	# Disable Fast Startup (Hiberboot)
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0

	# Prevent Dev Home Installation
	Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\DevHomeUpdate" -Force -ErrorAction SilentlyContinue

	# Prevent New Outlook for Windows Installation
	Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\OutlookUpdate" -Force -ErrorAction SilentlyContinue

	# Prevent Chat Auto Installation
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications" -Name "ConfigureChatAutoInstall" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Chat" -Name "ChatIcon" -PropertyType DWord -Value 3 -Force

	# Disable Account Info
	Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" -Name "Value" -Value "Deny" -Force

	# Disable Startup Sound
	New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" -Name "DisableStartupSound" -PropertyType DWord -Value 1 -Force

	# Disable Startup Sound in Edition Overrides
	New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\EditionOverrides" -Name "UserSetting_DisableStartupSound" -PropertyType DWord -Value 1 -Force

	# Disable launch of accessibility tools
	New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SlateLaunch" -Name "ATapp" -PropertyType String -Value "" -Force
	New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SlateLaunch" -Name "LaunchAT" -PropertyType DWord -Value 0 -Force

	# Disable ease of access settings
	New-ItemProperty -Path "HKCU:\Software\Microsoft\Ease of Access" -Name "selfvoice" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKCU:\Software\Microsoft\Ease of Access" -Name "selfscan" -PropertyType DWord -Value 0 -Force

	New-ItemProperty -Path "HKCU:\Control Panel\Accessibility" -Name "Sound on Activation" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKCU:\Control Panel\Accessibility" -Name "Warning Sounds" -PropertyType DWord -Value 0 -Force

	# Remove 3D objects
	Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Force
	Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Force

	# Remove Home Folder
	Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}" -Force

	# Disable archive apps
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Appx" -Name "AllowAutomaticAppArchiving" -PropertyType DWord -Value 0 -Force

	# Disable remote assistance
	New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -PropertyType DWord -Value 0 -Force

	# Disable automatic maintenance
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" -Name "MaintenanceDisabled" -PropertyType DWord -Value 1 -Force

	# Disable report problems
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -PropertyType DWord -Value 1 -Force

	# Disable use my sign-in info after restart
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableAutomaticRestartSignOn" -PropertyType DWord -Value 1 -Force

	# Disable allowing other network users to control or disable the shared internet connection
	New-ItemProperty -Path "HKLM:\System\ControlSet001\Control\Network\SharedAccessConnection" -Name "EnableControl" -PropertyType DWord -Value 0 -Force

	# Remove All Pinned Apps from the Start Menu
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "ConfigureStartPins" -PropertyType String -Value '{ "pinnedList": [] }' -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "ConfigureStartPins_ProviderSet" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "ConfigureStartPins_WinningProvider" -PropertyType String -Value "B5292708-1619-419B-9923-E5D9F3925E71" -Force

	# Remove All Pinned Apps from the Start Menu (additional provider)
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\providers\B5292708-1619-419B-9923-E5D9F3925E71\default\Device\Start" -Name "ConfigureStartPins" -PropertyType String -Value '{ "pinnedList": [] }' -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\providers\B5292708-1619-419B-9923-E5D9F3925E71\default\Device\Start" -Name "ConfigureStartPins_LastWrite" -PropertyType DWord -Value 1 -Force

	# Block "Allow my organization to manage my device" pop-ups
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin" -Name "BlockAADWorkplaceJoin" -PropertyType DWord -Value 1 -Force

	# disable search highlights
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDynamicSearchBoxEnabled" -Value 0

	# disable search history
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDeviceSearchHistoryEnabled" -Value 0

	# disable safe search
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "SafeSearchMode" -Value 0

	# disable cloud content search for work or school account
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsAADCloudSearchEnabled" -Value 0

	# disable cloud content search for microsoft account
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsMSACloudSearchEnabled" -Value 0

	# disable show the voice typing mic button
	# disable typing insights
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\input\Settings" -Name "IsVoiceTypingKeyEnabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\input\Settings" -Name "InsightsEnabled" -Value 0

	# disable capitalize the first letter of each sentence
	# disable play key sounds as I type
	# disable add a period after I double-tap the spacebar
	# disable show key background
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\TabletTip\1.7" -Name "EnableAutoShiftEngage" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\TabletTip\1.7" -Name "EnableKeyAudioFeedback" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\TabletTip\1.7" -Name "EnableDoubleTapSpace" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\TabletTip\1.7" -Name "IsKeyBackgroundEnabled" -Value 0

	# Disable match my windows accent color
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Lighting" -Name "UseSystemAccentColor" -Value 0

	# Disable Automatic Driver Installation
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Update" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force -BackgroundColor Black -NoNewline
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Update" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate" -Name "value" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "DontSearchWindowsUpdate" -PropertyType DWord -Value 1 -Force
}

Function Tweaks-Sch-Tasks {
		$Host.UI.RawUI.WindowTitle = "Muchility - Scheduled Tasks"														# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	Clear-Host
  	Write-Host "Scheduled Tasks!"
	Start-Sleep -Seconds 2
  # Disables Telemetry
  # Disable Scheduled Tasks
  $scheduledTasks = @(
      "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser",
      "Microsoft\Windows\Application Experience\ProgramDataUpdater",
      "Microsoft\Windows\Autochk\Proxy",
      "Microsoft\Windows\Customer Experience Improvement Program\Consolidator",
      "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip",
      "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector",
      "Microsoft\Windows\Feedback\Siuf\DmClient",
      "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload",
      "Microsoft\Windows\Windows Error Reporting\QueueReporting",
      "Microsoft\Windows\Application Experience\MareBackup",
      "Microsoft\Windows\Application Experience\StartupAppTask",
      "Microsoft\Windows\Application Experience\PcaPatchDbTask",
      "Microsoft\Windows\Maps\MapsUpdateTask"
  )
  foreach ($task in $scheduledTasks) {
      schtasks /Change /TN $task /Disable
  }
}

Function Tweaks-Delete-OneDrive {
		$Host.UI.RawUI.WindowTitle = "Muchility - Deleting OneDrive"														# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	Clear-Host
  	Write-Host "Deleting OneDrive!"
	Start-Sleep -Seconds 2
  
  # Check if OneDrive exists for each user
Get-ChildItem "$env:SystemDrive\Users" | ForEach-Object {
    if (Test-Path "$($_.FullName)\OneDrive") {
        if ((Get-ChildItem "$($_.FullName)\OneDrive" -File).Count -gt 0) {
            Write-Host "Not stripping OneDrive as OneDrive files exist, exiting..."
            exit 6000
        }
    }
}

# Terminate OneDrive process
Stop-Process -Name "OneDrive" -Force -ErrorAction SilentlyContinue

# Uninstall OneDrive Setup if it exists
$oneDrivePaths = @(
    "$env:windir\System32\OneDriveSetup.exe",
    "$env:windir\SysWOW64\OneDriveSetup.exe"
)

foreach ($path in $oneDrivePaths) {
    if (Test-Path $path) {
        & $path /uninstall | Out-Null
    }
}

# Remove OneDrive related files and registry entries for users with "Volatile Environment"
Get-ChildItem "HKU:\" | Where-Object { $_.Name -match 'S-.*' -or $_.Name -match 'AME_UserHive_[^_]*' } | ForEach-Object {
    $userKey = $_.Name
    $volEnvKey = "HKU\$userKey\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\BannerStore"
    if (Test-Path $volEnvKey) {
        Write-Host "Making changes for $userKey..."
        Remove-ItemProperty -Path "HKU\$userKey\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\BannerStore" -Name "OneDrive" -Force -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKU\$userKey\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\Handlers" -Name "OneDrive" -Force -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKU\$userKey\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths" -Name "OneDrive" -Force -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKU\$userKey\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" -Name "OneDrive" -Force -ErrorAction SilentlyContinue
    }
}

# Remove OneDrive related directories
Remove-Item -Path "$env:ProgramData\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue

# Remove user-specific OneDrive directories
Get-ChildItem "$env:SystemDrive\Users" | ForEach-Object {
    Remove-Item -Path "$($_.FullName)\AppData\Local\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$($_.FullName)\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$($_.FullName)\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" -Force -ErrorAction SilentlyContinue
}

# Delete OneDrive registry entries
Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SyncRootManager" | Where-Object { $_.Name -like "*OneDrive*" } | ForEach-Object {
    Remove-Item -Path $_.PSPath -Force -ErrorAction SilentlyContinue
}

# Delete scheduled tasks for OneDrive
Get-ScheduledTask | Where-Object { $_.TaskName -match "OneDrive Reporting Task|OneDrive Standalone Update Task" } | ForEach-Object {
    Unregister-ScheduledTask -TaskName $_.TaskName -Force -ErrorAction SilentlyContinue
}


}

Function Tweaks-KBM {
		$Host.UI.RawUI.WindowTitle = "Muchility - KBM Tweaks"														# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	Clear-Host	
	Write-Host "KBM Tweaks!"
	Start-Sleep -Seconds 2
	
# Disable DPI scaling
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "UseDpiScaling" -Value 0
	
# Set keyboard response flags and settings
New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "Flags" -PropertyType String -Value "2" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "AutoRepeatRate" -PropertyType String -Value "0" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "AutoRepeatDelay" -PropertyType String -Value "0" -Force

# Set mouse keys settings
New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\MouseKeys" -Name "Flags" -PropertyType String -Value "130" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\MouseKeys" -Name "MaximumSpeed" -PropertyType String -Value "39" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\MouseKeys" -Name "TimeToMaximumSpeed" -PropertyType String -Value "3000" -Force

# Set sticky keys flags
New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -PropertyType String -Value "2" -Force

# Set toggle keys flags
New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\ToggleKeys" -Name "Flags" -PropertyType String -Value "34" -Force
	
# Adjust mouse settings
New-ItemProperty -Path "HKU\.DEFAULT\Control Panel\Mouse" -Name "MouseSpeed" -PropertyType String -Value "0" -Force
New-ItemProperty -Path "HKU\.DEFAULT\Control Panel\Mouse" -Name "MouseThreshold1" -PropertyType String -Value "0" -Force
New-ItemProperty -Path "HKU\.DEFAULT\Control Panel\Mouse" -Name "MouseThreshold2" -PropertyType String -Value "0" -Force

# Disable enhance pointer precision (mouse fix, no accel with EPP on)
New-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -PropertyType String -Value "0" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -PropertyType String -Value "0" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -PropertyType String -Value "0" -Force
New-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSensitivity" -PropertyType String -Value "10" -Force

# Set custom mouse curve settings (SmoothMouseXCurve and SmoothMouseYCurve)
New-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "SmoothMouseXCurve" -PropertyType Binary -Value ([byte[]]@(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 0xCC, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x99, 0x19, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x66, 0x26, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x33, 0x33, 0x00, 0x00, 0x00, 0x00, 0x00)) -Force
New-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "SmoothMouseYCurve" -PropertyType Binary -Value ([byte[]]@(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x70, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xA8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00)) -Force

# Add "KeyboardDataQueueSize" to the kbdclass registry
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" -Name "KeyboardDataQueueSize" -Value 30 -Type DWord

# Add "MouseDataQueueSize" to the mouclass registry
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" -Name "MouseDataQueueSize" -Value 30 -Type DWord
}

Function Tweaks-Services {
		$Host.UI.RawUI.WindowTitle = "Muchility - Optimizing Services"													# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	Clear-Host
  	Write-Host "Optimizing Services!"
	Start-Sleep -Seconds 2
  
    # Set Services to Manual
  Set-Service -Name 'AJRouter' -StartupType Disabled -ErrorAction Continue
  Set-Service -Name 'ALG' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'AppIDSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'AppMgmt' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'AppReadiness' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'AppVClient' -StartupType Disabled -ErrorAction Continue
  Set-Service -Name 'AppXSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'Appinfo' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'AssignedAccessManagerSvc' -StartupType Disabled -ErrorAction Continue
  Set-Service -Name 'AudioEndpointBuilder' -StartupType Automatic -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'AudioSrv' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'Audiosrv' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'AxInstSV' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'BDESVC' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'BFE' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'BTAGService' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'BcastDVRUserService_*' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'BrokerInfrastructure' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'Browser' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'BthAvctpSvc' -StartupType Automatic -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'BthHFSrv' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'CDPSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'CDPUserSvc_*' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'COMSysApp' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'CaptureService_*' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'CertPropSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'ClipSVC' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'ConsentUxUserSvc_*' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'CoreMessagingRegistrar' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'CredentialEnrollmentManagerUserSvc_*' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'CryptSvc' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'CscService' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'DPS' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'DcomLaunch' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'DcpSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'DevQueryBroker' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'DeviceAssociationBrokerSvc_*' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'DeviceAssociationService' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'DeviceInstall' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'DevicePickerUserSvc_*' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'DevicesFlowUserSvc_*' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'Dhcp' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'DiagTrack' -StartupType Disabled -ErrorAction Continue
  Set-Service -Name 'DialogBlockingService' -StartupType Disabled -ErrorAction Continue
  Set-Service -Name 'DispBrokerDesktopSvc' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'DisplayEnhancementService' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'DmEnrollmentSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'Dnscache' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'DoSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'DsSvc' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'DsmSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'DusmSvc' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'EFS' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'EapHost' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'EntAppSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'EventLog' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'EventSystem' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'FDResPub' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'Fax' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'FontCache' -StartupType Automatic -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'FrameServer' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'FrameServerMonitor' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'GraphicsPerfSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'HomeGroupListener' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'HomeGroupProvider' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'HvHost' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'IEEtwCollectorService' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'IKEEXT' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'InstallService' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'InventorySvc' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'IpxlatCfgSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'KeyIso' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'KtmRm' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'LSM' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'LanmanServer' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'LanmanWorkstation' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'LicenseManager' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'LxpSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'MSDTC' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'MSiSCSI' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'MapsBroker' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'McpManagementService' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'MessagingService_*' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'MicrosoftEdgeElevationService' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'MixedRealityOpenXRSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'MpsSvc' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'MsKeyboardFilter' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'NPSMSvc_*' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'NaturalAuthentication' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'NcaSvc' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'NcbService' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'NcdAutoSetup' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'NetSetupSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'NetTcpPortSharing' -StartupType Disabled -ErrorAction Continue
  Set-Service -Name 'Netlogon' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'Netman' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'NgcCtnrSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'NgcSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'NlaSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'OneSyncSvc_*' -StartupType Automatic -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'P9RdrService_*' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'PNRPAutoReg' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'PNRPsvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'PcaSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'PeerDistSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'PenService_*' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'PerfHost' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'PhoneSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'PimIndexMaintenanceSvc_*' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'PlugPlay' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'PolicyAgent' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'Power' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'PrintNotify' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'PrintWorkflowUserSvc_*' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'ProfSvc' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'PushToInstall' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'QWAVE' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'RasAuto' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'RasMan' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'RemoteAccess' -StartupType Disabled -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'RemoteRegistry' -StartupType Disabled -ErrorAction Continue
  Set-Service -Name 'RetailDemo' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'RmSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'RpcEptMapper' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'RpcLocator' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'RpcSs' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'SCPolicySvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'SCardSvr' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'SDRSVC' -StartupType Manual -ErrorAction Continue 
  Set-Service -Name 'SEMgrSvc' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'SENS' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'SNMPTRAP' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'SNMPTrap' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'SSDPSRV' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'SamSs' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'ScDeviceEnum' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'Schedule' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'SecurityHealthService' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'Sense' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'SensorDataService' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'SensorService' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'SensrSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'SessionEnv' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'SgrmBroker' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'SharedAccess' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'SharedRealitySvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'ShellHWDetection' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'SmsRouter' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'Spooler' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'SstpSvc' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'StateRepository' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'StiSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'StorSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'SysMain' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'SystemEventsBroker' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'TabletInputService' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'TapiSrv' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'TermService' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'TextInputManagementService' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'Themes' -StartupType Automatic -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'TieringEngineService' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'TimeBroker' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'TimeBrokerSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'TokenBroker' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'TrkWks' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'TroubleshootingSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'TrustedInstaller' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'UI0Detect' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'UdkUserSvc_*' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'UevAgentService' -StartupType Disabled -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'UmRdpService' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'UnistoreSvc_*' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'UserDataSvc_*' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'UserManager' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'UsoSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'VGAuthService' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'VMTools' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'VSS' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'VacSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'VaultSvc' -StartupType Automatic -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'W32Time' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WEPHOSTSVC' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WFDSConMgrSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WMPNetworkSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WManSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WPDBusEnum' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WSService' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WSearch' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WaaSMedicSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WalletService' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'WarpJITSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WbioSrvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'Wcmsvc' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'WcsPlugInService' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WdNisSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WdiServiceHost' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WdiSystemHost' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WebClient' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'Wecsvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WerSvc' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'WiaRpc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WinDefend' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'WinHttpAutoProxySvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WinRM' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'Winmgmt' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'WlanSvc' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'WpcMonSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WpnService' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'WpnUserService_*' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'WwanSvc' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'XblAuthManager' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'XblGameSave' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'XboxGipSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'XboxNetApiSvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'autotimesvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'bthserv' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'camsvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'cbdhsvc_*' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'cloudidsvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'dcsvc' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'defragsvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'diagnosticshub.standardcollector.service' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'diagsvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'dmwappushservice' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'dot3svc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'edgeupdate' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'edgeupdatem' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'embeddedmode' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'fdPHost' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'fhsvc' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'gpsvc' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'hidserv' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'icssvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'iphlpsvc' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'lfsvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'lltdsvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'lmhosts' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'mpssvc' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'msiserver' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'netprofm' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'nsi' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'p2pimsvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'p2psvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'perceptionsimulation' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'pla' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'seclogon' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'shpamsvc' -StartupType Disabled -ErrorAction Continue
  Set-Service -Name 'smphost' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'spectrum' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'sppsvc' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'ssh-agent' -StartupType Disabled -ErrorAction Continue
  Set-Service -Name 'svsvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'swprv' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'tiledatamodelsvc' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'tzautoupdate' -StartupType Disabled -ErrorAction Continue
  Set-Service -Name 'uhssvc' -StartupType Disabled -ErrorAction Continue
  Set-Service -Name 'upnphost' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'vds' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'vm3dservice' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'vmicguestinterface' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'vmicheartbeat' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'vmickvpexchange' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'vmicrdv' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'vmicshutdown' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'vmictimesync' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'vmicvmsession' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'vmicvss' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'vmvss' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'wbengine' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'wcncsvc' -StartupType Manual -ErrorAction Continue
  Clear-Host
  Set-Service -Name 'webthreatdefsvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'webthreatdefusersvc_*' -StartupType Automatic -ErrorAction Continue
  Set-Service -Name 'wercplsupport' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'wisvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'wlidsvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'wlpasvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'wmiApSrv' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'workfolderssvc' -StartupType Manual -ErrorAction Continue
  Set-Service -Name 'wudfsvc' -StartupType Manual -ErrorAction Continue
}

Function Tweaks-Debloat {
		$Host.UI.RawUI.WindowTitle = "Muchility - Debloating"														# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	Clear-Host
	Write-Host "Debloating!"
	Start-Sleep -Seconds 2


Get-AppxProvisionedPackage -Online |
  Where-Object -Property 'DisplayName' -In -Value @(
  'Microsoft.Microsoft3DViewer';
  'Microsoft.BingSearch';
  'Microsoft.WindowsCamera';
  'Clipchamp.Clipchamp';
  'Microsoft.WindowsAlarms';
  'Microsoft.549981C3F5F10';
  'Microsoft.Windows.DevHome';
  'MicrosoftCorporationII.MicrosoftFamily';
  'Microsoft.WindowsFeedbackHub';
  'Microsoft.GetHelp';
  'microsoft.windowscommunicationsapps';
  'Microsoft.WindowsMaps';
  'Microsoft.ZuneVideo';
  'Microsoft.BingNews';
  'Microsoft.MicrosoftOfficeHub';
  'Microsoft.Office.OneNote';
  'Microsoft.OutlookForWindows';
  'Microsoft.Paint';
  'Microsoft.MSPaint';
  'Microsoft.People';
  'Microsoft.Windows.Photos';
  'Microsoft.PowerAutomateDesktop';
  'MicrosoftCorporationII.QuickAssist';
  'Microsoft.SkypeApp';
  'Microsoft.ScreenSketch';
  'Microsoft.MicrosoftSolitaireCollection';
  'Microsoft.MicrosoftStickyNotes';
  'MSTeams';
  'Microsoft.Getstarted';
  'Microsoft.Todos';
  'Microsoft.WindowsSoundRecorder';
  'Microsoft.BingWeather';
  'Microsoft.ZuneMusic';
  'Microsoft.WindowsTerminal';
  'Microsoft.Xbox.TCUI';
  'Microsoft.XboxApp';
  'Microsoft.XboxGameOverlay';
  'Microsoft.XboxGamingOverlay';
  'Microsoft.XboxIdentityProvider';
  'Microsoft.XboxSpeechToTextOverlay';
  'Microsoft.GamingApp';
  'Microsoft.YourPhone';
  'Microsoft.MicrosoftEdge';
  'Microsoft.MicrosoftEdge.Stable';
  'Microsoft.MicrosoftEdge_8wekyb3d8bbwe';
  'Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe';
  'Microsoft.MicrosoftEdgeDevToolsClient_1000.19041.1023.0_neutral_neutral_8wekyb3d8bbwe';
  'Microsoft.MicrosoftEdge_44.19041.1266.0_neutral__8wekyb3d8bbwe';
  'Microsoft.OneDrive';
  'Microsoft.MicrosoftEdgeDevToolsClient';
  'Microsoft.549981C3F5F10';
  'Microsoft.MixedReality.Portal';
  'Microsoft.Windows.Ai.Copilot.Provider';
  'Microsoft.WindowsMeetNow';
) | Remove-AppxProvisionedPackage -AllUsers -Online


Clear-Host


Get-WindowsCapability -Online |
Where-Object -FilterScript {
  ($_.Name -split '~')[0] -in @(
    'Browser.InternetExplorer';
    'MathRecognizer';
    'OpenSSH.Client';
    'Microsoft.Windows.PowerShell.ISE';
    'App.Support.QuickAssist';
    'App.StepsRecorder';
  );
} | Remove-WindowsCapability -Online
    
	Clear-Host
  # Enables .NET Framework 3.5
  DISM /Online /Enable-Feature /FeatureName:NetFx3 /All /Source:X:\sources\sxs /LimitAccess
  Clear-Host
  # Configure Maximum Password Age in Windows
  net.exe accounts /maxpwage:UNLIMITED
  
  # Allow Execution of PowerShell Script Files
  Set-ExecutionPolicy -Scope 'LocalMachine' -ExecutionPolicy 'RemoteSigned' -Force
  
  # Groups or splits svchost.exe processes based on the amount of physical memory in the system to optimize performance
  $ram = (Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb
  Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value $ram -Force
  
  $autoLoggerDir = "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger"
  If (Test-Path "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl") {
      Remove-Item "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl"
  }
  $icaclsCommand = "icacls `"$autoLoggerDir`" /deny SYSTEM:`"(OI)(CI)F`""
  Invoke-Expression $icaclsCommand | Out-Null
  Clear-Host
  # Disable Defender Auto Sample Submission
  Set-MpPreference -SubmitSamplesConsent 2 -ErrorAction Continue | Out-Null
  
  # Removes Microsoft Edge
  foreach ($line in $lines) {
      if ($line -like '*Architecture : *') {
          $architecture = $line -replace 'Architecture : ',''
          # If the architecture is x64, replace it with amd64
          if ($architecture -eq 'x64') {
              $architecture = 'amd64'
          }
          Write-Host "Architecture: $architecture"
          break
      }
  }
  
  if (-not $architecture) {
      Write-Host "Architecture information not found."
  }
  Remove-Item -Path "C:\Program Files (x86)\Microsoft\Edge" -Recurse -Force -ErrorAction Continue
  Remove-Item -Path "C:\Program Files (x86)\Microsoft\EdgeWebView" -Recurse -Force -ErrorAction Continue
  Remove-Item -Path "C:\Program Files (x86)\Microsoft\EdgeUpdate" -Recurse -Force -ErrorAction Continue
  Remove-Item -Path "C:\Program Files (x86)\Microsoft\EdgeCore" -Recurse -Force -ErrorAction Continue
  Remove-Item -Path "C:\Users\Public\Desktop\Microsoft Edge.lnk" -Recurse -Force -ErrorAction Continue
  Remove-Item -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk" -Recurse -Force -ErrorAction Continue
  Remove-Item -Path "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" -Recurse -Force -ErrorAction Continue
  Remove-Item -Path "C:\Windows\SystemApps\Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe" -Recurse -Force -ErrorAction Continue
  if ($architecture -eq 'amd64') {
      $folderPath = Get-ChildItem -Path "C:\Windows\WinSxS" -Filter "amd64_microsoft-edge-webview_31bf3856ad364e35*" -Directory | Select-Object -ExpandProperty FullName
  
      if ($folderPath) {
          & 'takeown' '/f' $folderPath '/r' 
          & icacls $folderPath  "/grant" "$($adminGroup.Value):(F)" '/T' '/C' 
          Remove-Item -Path $folderPath -Recurse -Force 
      } else {
          Write-Host "Folder not found."
      }
  } elseif ($architecture -eq 'arm64') {
      $folderPath = Get-ChildItem -Path "C:\Windows\WinSxS" -Filter "arm64_microsoft-edge-webview_31bf3856ad364e35*" -Directory | Select-Object -ExpandProperty FullName
  
      if ($folderPath) {
          & 'takeown' '/f' $folderPath '/r'
          & icacls $folderPath  "/grant" "$($adminGroup.Value):(F)" '/T' '/C' 
          Remove-Item -Path $folderPath -Recurse -Force 
      } else {
          Write-Host "Folder not found."
      }
  } else {
      Write-Host "Unknown architecture: $architecture"
  }
  & 'takeown' '/f' "C:\Windows\System32\Microsoft-Edge-Webview" '/r' 
  & 'icacls' "C:\Windows\System32\Microsoft-Edge-Webview" '/grant' "$($adminGroup.Value):(F)" '/T' '/C' 
  Remove-Item -Path "C:\Windows\System32\Microsoft-Edge-Webview" -Recurse -Force
  Clear-Host
  # Removes OneDrive
  Remove-Item "C:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" -ErrorAction Continue
  Remove-Item "C:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.exe" -ErrorAction Continue
  Remove-Item "C:\Windows\System32\OneDriveSetup.exe" -ErrorAction Continue
  Remove-Item "C:\Windows\SysWOW64\OneDriveSetup.exe" -ErrorAction Continue
   
  # Removes Microsoft Teams
  $TeamsPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, 'Microsoft', 'Teams')
  $TeamsUpdateExePath = [System.IO.Path]::Combine($TeamsPath, 'Update.exe')
  
  Stop-Process -Name "*teams*" -Force -ErrorAction Continue
  
  if ([System.IO.File]::Exists($TeamsUpdateExePath)) {
      # Uninstall app
      $proc = Start-Process $TeamsUpdateExePath "-uninstall -s" -PassThru
      $proc.WaitForExit()
  }
  
  Get-AppxPackage "*Teams*" | Remove-AppxPackage -ErrorAction Continue
  Get-AppxPackage "*Teams*" -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction Continue
  
  if ([System.IO.Directory]::Exists($TeamsPath)) {
      Remove-Item $TeamsPath -Force -Recurse -ErrorAction Continue
  }
  Clear-Host
  # Uninstall from Uninstall registry key UninstallString
  $us = (Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall | Get-ItemProperty | Where-Object { $_.DisplayName -like '*Teams*'}).UninstallString
  if ($us.Length -gt 0) {
      $us = ($us.Replace('/I', '/uninstall ') + ' /quiet').Replace('  ', ' ')
      $FilePath = ($us.Substring(0, $us.IndexOf('.exe') + 4).Trim())
      $ProcessArgs = ($us.Substring($us.IndexOf('.exe') + 5).Trim().replace('  ', ' '))
      $proc = Start-Process -FilePath $FilePath -Args $ProcessArgs -PassThru
      $proc.WaitForExit()
  }
  
  # Disables Teredo
  $registryKeysTeredo = @(
      @{Path = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"; Name = "DisabledComponents"; Type = "DWord"; Value = 1}
  )
  foreach ($key in $registryKeysTeredo) {
      New-ItemProperty -Path $key.Path -Name $key.Name -PropertyType $key.Type -Value $key.Value -Force
  }
  netsh interface teredo set state disabled
	
}



# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!





# Below is ripped from CTT WinUtil +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Function Get-WinUtilWingetLatest {
    <#
    .SYNOPSIS
        Uses GitHub API to check for the latest release of Winget.
    .DESCRIPTION
        This function grabs the latest version of Winget and returns the download path to Install-WinUtilWinget for installation.
    #>
    # Invoke-WebRequest is notoriously slow when the byte progress is displayed. The following lines disable the progress bar and reset them at the end of the function
    $PreviousProgressPreference = $ProgressPreference
    $ProgressPreference = "silentlyContinue"
    try {
        # Grabs the latest release of Winget from the Github API for the install process.
        $response = Invoke-RestMethod -Uri "https://api.github.com/repos/microsoft/Winget-cli/releases/latest" -Method Get -ErrorAction Stop
        $latestVersion = $response.tag_name #Stores version number of latest release.
        $licenseWingetUrl = $response.assets.browser_download_url | Where-Object {$_ -like "*License1.xml"} #Index value for License file.
        Write-Host "Latest Version:`t$($latestVersion)`n"
        Write-Host "Downloading..."
        $assetUrl = $response.assets.browser_download_url | Where-Object {$_ -like "*Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"}
        Invoke-WebRequest -Uri $licenseWingetUrl -OutFile $ENV:TEMP\License1.xml
        # The only pain is that the msixbundle for winget-cli is 246MB. In some situations this can take a bit, with slower connections.
        Invoke-WebRequest -Uri $assetUrl -OutFile $ENV:TEMP\Microsoft.DesktopAppInstaller.msixbundle
    } catch {
        Write-Host "Failed to get Winget!"
    }
    $ProgressPreference = $PreviousProgressPreference
}

Function Get-WinUtilWingetPrerequisites {
    <#
    .SYNOPSIS
        Downloads the Winget Prereqs.
    .DESCRIPTION
        Downloads Prereqs for Winget. Version numbers are coded as variables and can be updated as uncommonly as Microsoft updates the prereqs.
    #>

    # I don't know of a way to detect the prereqs automatically, so if someone has a better way of defining these, that would be great.
    # Microsoft.VCLibs version rarely changes, but for future compatibility I made it a variable.
    $versionVCLibs = "14.00"
    $fileVCLibs = "https://aka.ms/Microsoft.VCLibs.x64.${versionVCLibs}.Desktop.appx"
    # Write-Host "$fileVCLibs"
    # Microsoft.UI.Xaml version changed recently, so I made the version numbers variables.
    $versionUIXamlMinor = "2.8"
    $versionUIXamlPatch = "2.8.6"
    $fileUIXaml = "https://github.com/microsoft/microsoft-ui-xaml/releases/download/v${versionUIXamlPatch}/Microsoft.UI.Xaml.${versionUIXamlMinor}.x64.appx"
    # Write-Host "$fileUIXaml"

    try {
        Write-Host "Downloading Microsoft.VCLibs Dependency..."
        Invoke-WebRequest -Uri $fileVCLibs -OutFile $ENV:TEMP\Microsoft.VCLibs.x64.Desktop.appx
        Write-Host "Downloading Microsoft.UI.Xaml Dependency...`n"
        Invoke-WebRequest -Uri $fileUIXaml -OutFile $ENV:TEMP\Microsoft.UI.Xaml.x64.appx
    } catch {
        Write-Host "Failed to install Winget Dependencies!"
    }
}

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!





# Below is 2nd Check Functions

# Set the registry value to allow restore points every 2 minutes
Function Set-RestorePointFrequency {
    try {
        $registryPath = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore"
        $valueName = "SystemRestorePointCreationFrequency"
        $valueData = 2

        if (-not (Test-Path $registryPath)) {
            throw "Registry path $registryPath does not exist."
        }

        Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Force > $null 2>&1
    } catch {
        # Suppress error, silently handle failure
        exit
    }
}

# Function to check if restore points are enabled
Function Check-RestorePointStatus {
    $vssOutput = vssadmin list shadowstorage

    if ($vssOutput -match "No shadow copies are available") {
        return $false
    } else {
        return $true
    }
}

# Function to enable restore points on the current drive
Function Enable-RestorePoints {
    Write-Host "Enabling system restore on the current drive..." -ForegroundColor Magenta
    
    try {
        # Assuming you want to enable restore on C:\, modify as needed
        Enable-ComputerRestore -Drive "C:\"  # Replace C:\ with the desired drive letter
        Write-Host ""
        Write-Host "System restore is enabled on the drive." -ForegroundColor Green
		Start-Sleep -Seconds 2
        return $true
    } catch {
        Write-Host "Error: Could not enable system restore on the drive." -ForegroundColor DarkRed
		Start-Sleep -Seconds 2
        return $false
    }
}

# Function to check if a specific version of the Visual C++ Redistributable is installed
Function Is-VCRedistInstalled {
    param (
        [string]$version,        # The version of the redistributable
        [string]$architecture    # x86 or x64 architecture
    )
    
    # Get the installed packages from the registry
    $installedVCRedists = Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name LIKE 'Microsoft Visual C++ Redistributable%'" 

    # Check if the specific version is installed
    $vcredist = $installedVCRedists | Where-Object { $_.Name -like "Microsoft Visual C++ Redistributable for Visual Studio $version ($architecture)" }

    return $vcredist
}

# Function to download and install the Visual C++ Redistributables
Function Install-VCRedist {
    # Define the version and URL pairs for each Visual C++ Redistributable package (x86 and x64)
    $vcredistVersions = @(
        # Visual C++ 2005
        @{ Version = "2005"; x86Url = "https://aka.ms/vs/16/release/vc_redist.2005.x86.exe"; x64Url = "https://aka.ms/vs/16/release/vc_redist.2005.x64.exe" },
        # Visual C++ 2008
        @{ Version = "2008"; x86Url = "https://aka.ms/vs/16/release/vc_redist.2008.x86.exe"; x64Url = "https://aka.ms/vs/16/release/vc_redist.2008.x64.exe" },
        # Visual C++ 2010
        @{ Version = "2010"; x86Url = "https://aka.ms/vs/16/release/vc_redist.2010.x86.exe"; x64Url = "https://aka.ms/vs/16/release/vc_redist.2010.x64.exe" },
        # Visual C++ 2012
        @{ Version = "2012"; x86Url = "https://aka.ms/vs/16/release/vc_redist.2012.x86.exe"; x64Url = "https://aka.ms/vs/16/release/vc_redist.2012.x64.exe" },
        # Visual C++ 2013
        @{ Version = "2013"; x86Url = "https://aka.ms/vs/16/release/vc_redist.2013.x86.exe"; x64Url = "https://aka.ms/vs/16/release/vc_redist.2013.x64.exe" },
        # Visual C++ 2015-2019
        @{ Version = "2015-2019"; x86Url = "https://aka.ms/vs/16/release/vc_redist.x86.exe"; x64Url = "https://aka.ms/vs/16/release/vc_redist.x64.exe" },
        # Visual C++ 2022
        @{ Version = "2022"; x86Url = "https://aka.ms/vs/17/release/vc_redist.x86.exe"; x64Url = "https://aka.ms/vs/17/release/vc_redist.x64.exe" }
    )

    # Create a custom temporary folder for downloading
    $tempFolder = "C:\_temp"
    if (-not (Test-Path -Path $tempFolder)) {
        New-Item -ItemType Directory -Path $tempFolder
    }
clear-host
    # Loop through each version and check if installation is needed
    foreach ($vcredist in $vcredistVersions) {
        $isInstalled = $false
        $x86Installed = Is-VCRedistInstalled -version $vcredist.Version -architecture "x86"
        $x64Installed = Is-VCRedistInstalled -version $vcredist.Version -architecture "x64"

        $installResults = @{}

        # Check if x86 is installed, if not, download and install
        if (-not $x86Installed) {
            $installResults["x86"] = "Installing"
            $x86File = "$tempFolder\vcredist_x86_$($vcredist.Version).exe"
            Write-Host "Downloading Visual C++ $($vcredist.Version) (x86)..."
            Invoke-WebRequest -Uri $vcredist.x86Url -OutFile $x86File
            if (Test-Path $x86File) {
                Start-Process -FilePath $x86File -ArgumentList "/install /quiet /norestart" -Wait
                $installResults["x86"] = "Installed"
            } else {
                $installResults["x86"] = "Failed"
            }
        } else {
            $installResults["x86"] = "Already Installed"
        }

        # Check if x64 is installed, if not, download and install
        if (-not $x64Installed) {
            $installResults["x64"] = "Installing"
            $x64File = "$tempFolder\vcredist_x64_$($vcredist.Version).exe"
            Write-Host "Downloading Visual C++ $($vcredist.Version) (x64)..."
            Invoke-WebRequest -Uri $vcredist.x64Url -OutFile $x64File
            if (Test-Path $x64File) {
                Start-Process -FilePath $x64File -ArgumentList "/install /quiet /norestart" -Wait
                $installResults["x64"] = "Installed"
            } else {
                $installResults["x64"] = "Failed"
            }
        } else {
            $installResults["x64"] = "Already Installed"
        }

        # Output installation results with color highlighting
        Write-Host "Visual C++ $($vcredist.Version) (x86) status: " -NoNewline
        if ($installResults["x86"] -eq "Installed") {
            Write-Host "Installed" -ForegroundColor Green
        } elseif ($installResults["x86"] -eq "Failed") {
            Write-Host "Failed" -ForegroundColor DarkRed
        } else {
            Write-Host "Already Installed" -ForegroundColor Yellow
        }

        Write-Host "Visual C++ $($vcredist.Version) (x64) status: " -NoNewline
        if ($installResults["x64"] -eq "Installed") {
            Write-Host "Installed" -ForegroundColor Green
        } elseif ($installResults["x64"] -eq "Failed") {
            Write-Host "Failed" -ForegroundColor DarkRed
        } else {
            Write-Host "Already Installed" -ForegroundColor Yellow
        }

        # Add sleep and clear host before the next iteration
        Start-Sleep -Seconds 1
        Clear-Host
    }

    # Clean up the temporary folder
    Write-Host "Cleaning up temporary folder..."
    Remove-Item -Path $tempFolder -Recurse -Force

    Write-Host "All necessary Visual C++ Redistributables have been checked and installed as needed."
	Start-Sleep -Seconds 1
}

# Function to prompt user to install Visual C++ Redistributables
Function VC-User-Choice {
    # Prompt the user for input
	Clear-Host
    $userInput = Read-Host "Update Visual C++ Redistributables? (Y/N)"

    if ($userInput -eq 'Y') {
        Is-VCRedistInstalled
        Install-VCRedist

        Write-Host "Press any key to return to the main menu."
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
    elseif ($userInput -eq 'N') {
        Write-Host "Exiting the function."
        return
    }
    else {
        Write-Host "Invalid input. Please try again."
        VC-User-Choice # Recursive call for retry on invalid input
    }
}

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


do {
    Show-Menu
    $key = [System.Console]::ReadKey($true).KeyChar
    switch ($key) {
        "1" { Tweaks }
        "2" { BCD-Tweaks }
        "3" { Install-Choco } 
        "4" { Get-Winget }  
        "5" { Update-Apps } 
		"6" { Install-Browsers }  
        "7" { Disable-WindowsUpdate } 
		"8" { Enable-WindowsUpdate } 
		"9" { Create-RestorePoint }
		"T" { Clean-TempFolders }
		"U" { Remove-Winget }
		"C" { Remove-Choco }
		"A" { Activate-Win }
		"D" { cUpdate-Drivers }
		"S" { cSystem-Repairs }
		"M" { Show-Menu }
        default { Break }
    }
} while ($key -ne "0")






