#╔══╗══╗╔═╗═╗╔═══╗╔═╗╔═╗╔═╗"
#║*   *║║*║*║║*║*║║*╚╝*║╠-╣"
#║ ║ ║ ║║*║*║║*╚═╣║*╔╗*║║*║"
#╚═╩═╩═╝╚═══╝╚═══╝╚═╝╚═╝╚═╝"

$MuVer = "1.3"

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Latest updates post here
$MuchiLU = "Reworked Tweaks"

Function Muchility-Menu {
	$Host.UI.RawUI.WindowTitle = "Muchility - Created By Muchi"
	$Host.UI.RawUI.BackgroundColor = "Black"
	Clear-Host
	Write-Host "Welcome To Muchility" -ForegroundColor DarkRed -NoNewline
	Write-Host "					Created By Muchi " -ForegroundColor DarkRed
	Write-Host "Latest Update > " -NoNewline
	Write-Host "					$MuchiLU" -ForegroundColor Magenta
	Write-Host ""
	
	Write-Host "0. " -NoNewline 
	Write-Host "Restore Point" -NoNewline -ForegroundColor Cyan #############
	Write-Host "					Create A Restore Point" -ForegroundColor Cyan #############
	
    Write-Host "1. " -NoNewline 
	Write-Host "Run Tweaks" -NoNewline -ForegroundColor DarkCyan
	Write-Host "						Improve Performance, Remove Bloatware + More" -ForegroundColor Blue
	
	Write-Host "2. " -NoNewline 
	wRITE-hOST "BCD Tweaks" -NoNewline -ForegroundColor DarkCyan
	Write-Host "						Enable Highest Mode + More" -ForegroundColor Blue
	
	Write-Host "3. " -NoNewline 
	Write-Host "Install Choco" -NoNewline -ForegroundColor DarkCyan
	Write-Host "					Install Chocolatey" -ForegroundColor Blue
	
	Write-Host "4. " -NoNewline 
	Write-Host "Update Apps" -NoNewline -ForegroundColor DarkCyan
	Write-Host "						Update Software via Choco & Update C++" -ForegroundColor Blue
	
    Write-Host "5. " -NoNewline 
	Write-Host "Install Brave" -ForegroundColor DarkCyan -NoNewline
	Write-Host "					via Choco" -ForegroundColor Blue
	
	Write-Host "6. " -NoNewline 
    Write-Host "Windows Update" -ForegroundColor DarkCyan
	
	Write-Host "7. " -NoNewline 
	Write-Host "Activate Windows " -NoNewLine -ForegroundColor DarkCyan
	Write-Host "					HWID Activation" -ForegroundColor Blue
	
	Write-Host "8. " -NoNewline 
	Write-Host "Update Drivers" -NoNewline -ForegroundColor DarkCyan
	Write-Host "					Download & Install Drivers via SDI" -ForegroundColor Blue
	
	Write-Host "9. " -NoNewline 
	Write-Host "Repair System Files" -NoNewline -ForegroundColor DarkCyan
	Write-Host "					Check For Corrupted Files" -ForegroundColor Blue
	
	Write-Host "T. " -NoNewLine 
	Write-Host "Clear Temp Folders" -NoNewLine -ForegroundColor DarkCyan
	Write-Host "					Free Up Space & Delete Temporary Folders" -ForegroundColor Blue
	
	Write-Host "C. " -NoNewline 
	Write-Host "Uninstall Choco" -ForegroundColor DarkCyan
	
	Write-Host "M. " -NoNewline 
	Write-Host "Refresh Menu" -ForegroundColor DarkCyan -NoNewLine
	Write-Host "						App Version $MuVer - " -NoNewLine
	Write-Host "$cInternet" -ForegroundColor $color
	Write-Host ""
	
}

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!





# Below are all functions 0-9 & T,C

#0 //////////////////////////////////////////////////////////////////////////////
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

#1 //////////////////////////////////////////////////////////////////////////////
Function Tweaks {
	$Host.UI.RawUI.WindowTitle = "Muchility - Tweaks"
	AIO-Tweaks
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
Function Update-Apps {
    $Host.UI.RawUI.WindowTitle = "Muchility - Updating Apps"
    clear-host

    # Set the background color to black and text to white
    $Host.UI.RawUI.BackgroundColor = 'Black'
    clear-host
	
	Choco-Update-All
	VC-User-Choice
}

#5 //////////////////////////////////////////////////////////////////////////////
Function Install-Brave {
	choco feature enable -n allowGlobalConfirmation
    choco install brave
}

#6 //////////////////////////////////////////////////////////////////////////////
Function WinUp-Menu {
	$Host.UI.RawUI.WindowTitle = "Muchility - Windows Update"
    clear-host
    Write-Host "Select an option for Windows Update configuration:" -ForegroundColor Cyan
	Write-Host ""
    Write-Host "1. Security Updates Only		Configures Windows to install only security updates."
	Write-Host ""
    Write-Host "2. Disable All Updates 			Disables all Windows Update services and automatic updates."
	Write-Host ""
    Write-Host "3. Enable Updates 			Enables automatic Windows updates, restoring default behavior."
	Write-Host ""

    $choice = Read-Host "Choose 1, 2 OR 3?"

    switch ($choice) {
        1 {
            Write-Host "You selected 'Security Updates Only'." -ForegroundColor Green
            WinUp-Sec
        }
        2 {
            Write-Host "You selected 'Disable All Updates'." -ForegroundColor Red
            WinUp-Dis
        }
        3 {
            Write-Host "You selected 'Enable Updates'." -ForegroundColor Green
            WinUp-Ena
        }
        default {
            Write-Host "Invalid choice. Please select 1, 2, or 3." -ForegroundColor Yellow
        }
    }
}

#7 //////////////////////////////////////////////////////////////////////////////
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

#8 //////////////////////////////////////////////////////////////////////////////
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

#9 //////////////////////////////////////////////////////////////////////////////
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

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!





# Below is Tweak Functions 

Function Pplan1 {
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

Function SoftwareInstalls1 {
    # Registry path to enforce blocking policy
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions"

    # Create the registry key if it doesn't exist
    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }

    # Set policy to block all automatic installations
    Set-ItemProperty -Path $regPath -Name "DenyDeviceIDs" -Value $true

    # Additional registry setting to disable automatic driver downloads
    $driverPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceSetup"
    if (-not (Test-Path $driverPath)) {
        New-Item -Path $driverPath -Force | Out-Null
    }
    Set-ItemProperty -Path $driverPath -Name "DeviceSetupManager" -Value 0

    # Disable Windows Update from automatically fetching drivers
    $wuPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
    if (-not (Test-Path $wuPath)) {
        New-Item -Path $wuPath -Force | Out-Null
    }
    Set-ItemProperty -Path $wuPath -Name "ExcludeWUDriversInQualityUpdate" -Value 1

    Write-Host "All automatic installations and updates have been blocked."
}

Function Debloat1 {
	Write-Host "Removing Unneeded Apps!"
	Start-Sleep -Seconds 2
	$SafeApps = "AAD.brokerplugin|accountscontrol|apprep.chxapp|assignedaccess|asynctext|bioenrollment|capturepicker|cloudexperience|contentdelivery|desktopappinstaller|ecapp|edge|extension|getstarted|immersivecontrolpanel|lockapp|net.native|oobenet|parentalcontrols|PPIProjection|search|sechealth|secureas|shellexperience|startmenuexperience|terminal|vclibs|xaml|XGpuEject"
	If ($Xbox) {
		$SafeApps = "$SafeApps|Xbox" 
}
	
	If ($Allapps) {
		$RemoveApps = Get-AppxPackage -allusers | where-object {$_.name -notmatch $SafeApps}
		$RemovePrApps = Get-AppxProvisionedPackage -online | where-object {$_.displayname -notmatch $SafeApps}
			ForEach ($RemovedApp in $RemoveApps) {
				Remove-AppxPackage -package $RemovedApp -erroraction silentlycontinue
				
}			ForEach ($RemovedPrApp in $RemovePrApps) {
				Remove-AppxProvisionedPackage -online -packagename $RemovedPrApp.packagename -erroraction silentlycontinue
				
}
}	Else {
		$SafeApps = "$SafeApps|$GoodApps"
		$RemoveApps = Get-AppxPackage -allusers | where-object {$_.name -notmatch $SafeApps}
		$RemovePrApps = Get-AppxProvisionedPackage -online | where-object {$_.displayname -notmatch $SafeApps}
			ForEach ($RemovedApp in $RemoveApps) {
				Remove-AppxPackage -package $RemovedApp -erroraction silentlycontinue
				
}			ForEach ($RemovedPrApp in $RemovePrApps) {
				Remove-AppxProvisionedPackage -online -packagename $RemovedPrApp.packagename -erroraction silentlycontinue
				
}
}
}

Function Annoyances1 {
	clear-host
	Write-Host "Disabling, Preventing & Removing Annoyances!"
	Start-Sleep -Seconds 2
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications" -Name "ConfigureChatAutoInstall" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Chat" -Name "ChatIcon" -PropertyType DWord -Value 3 -Force
	New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" -Name "DisableStartupSound" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\EditionOverrides" -Name "UserSetting_DisableStartupSound" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SlateLaunch" -Name "ATapp" -PropertyType String -Value "" -Force
	New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SlateLaunch" -Name "LaunchAT" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKCU:\Software\Microsoft\Ease of Access" -Name "selfvoice" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKCU:\Software\Microsoft\Ease of Access" -Name "selfscan" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKCU:\Control Panel\Accessibility" -Name "Sound on Activation" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKCU:\Control Panel\Accessibility" -Name "Warning Sounds" -PropertyType DWord -Value 0 -Force	
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Appx" -Name "AllowAutomaticAppArchiving" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" -Name "MaintenanceDisabled" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableAutomaticRestartSignOn" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\System\ControlSet001\Control\Network\SharedAccessConnection" -Name "EnableControl" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "ConfigureStartPins" -PropertyType String -Value '{ "pinnedList": [] }' -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "ConfigureStartPins_ProviderSet" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "ConfigureStartPins_WinningProvider" -PropertyType String -Value "B5292708-1619-419B-9923-E5D9F3925E71" -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\providers\B5292708-1619-419B-9923-E5D9F3925E71\default\Device\Start" -Name "ConfigureStartPins" -PropertyType String -Value '{ "pinnedList": [] }' -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\providers\B5292708-1619-419B-9923-E5D9F3925E71\default\Device\Start" -Name "ConfigureStartPins_LastWrite" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin" -Name "BlockAADWorkplaceJoin" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" -Name "TurnOffWindowsCopilot" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive" -Name "KFMBlockOptIn" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\PushToInstall" -Name "DisablePushToInstall" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableConsumerAccountStateContent" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableCloudOptimizedContent" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\BitLocker" -Name "PreventDeviceEncryption" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EnhancedStorageDevices" -Name "TCGSecurityActivationDisabled" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Update" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force -BackgroundColor Black -NoNewline
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Update" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate" -Name "value" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "DontSearchWindowsUpdate" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" -Name "AllowWindowsInkWorkspace" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\StorageSense" -Name "AllowStorageSenseGlobal" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsRunInBackground" -PropertyType DWord -Value 2 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" -Name "value" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -PropertyType DWord -Value 1 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -PropertyType DWord -Value 0 -Force
	New-ItemProperty -Path "HKCU:\Control Panel\TimeDate" -Name "DstNotification" -PropertyType DWord -Value 0 -Force
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny" -Force
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SystemSettings\AccountNotifications" -Name "EnableAccountNotifications" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" -Name "AgentActivationEnabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" -Name "AgentActivationLastUsed" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" -Name "Value" -Value "Deny"
	Set-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\EdgeUI" -Name "DisableMFUTracking" -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "PeriodInNanoSeconds" -Value "-"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Windows" -Name "LegacyDefaultPrinterMode" -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\TabletTip\EmbeddedInkControl" -Name "EnableInkingWithTouch" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "LockScreenToastEnabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" -Name "NOC_GLOBAL_SETTING_ALLOW_NOTIFICATION_SOUND" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" -Name "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" -Name "NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" -Name "Enabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel" -Name "Enabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.CapabilityAccess" -Name "Enabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.StartupApp" -Name "Enabled" -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SmartActionPlatform\SmartClipboard" -Name "Disabled" -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\input" -Name "IsInputAppPreloadEnabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Dsh" -Name "IsPrelaunchEnabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot" -Name "TurnOffWindowsCopilot" -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\Outlook\Options\General" -Name "HideNewOutlookToggle" -Value 0
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power" -Name "HibernateEnabled" -Value 0
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power" -Name "HibernateEnabledDefault" -Value 0
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0
	Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" -Name "Value" -Value "Deny" -Force
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDynamicSearchBoxEnabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDeviceSearchHistoryEnabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "SafeSearchMode" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsAADCloudSearchEnabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsMSACloudSearchEnabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\input\Settings" -Name "IsVoiceTypingKeyEnabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\input\Settings" -Name "InsightsEnabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\TabletTip\1.7" -Name "EnableAutoShiftEngage" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\TabletTip\1.7" -Name "EnableKeyAudioFeedback" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\TabletTip\1.7" -Name "EnableDoubleTapSpace" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\TabletTip\1.7" -Name "IsKeyBackgroundEnabled" -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Lighting" -Name "UseSystemAccentColor" -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoStartMenuMFUprogramsList" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoInstrumentation" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" -Name "System.IsPinnedToNameSpaceTree"
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "OneDriveSetup"
	Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\DevHomeUpdate" -Force -ErrorAction SilentlyContinue
	Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\OutlookUpdate" -Force -ErrorAction SilentlyContinue
	Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Force
	Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Force
	Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}" -Force
}

Function Wifi-Sense1 {
    clear-host
    Write-Host "Disabling Wi-Fi Sense!"
    Start-Sleep -Seconds 2
    New-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -PropertyType DWord -Value 0 -Force
    New-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -PropertyType DWord -Value 0 -Force
}

Function Ads1 {
    clear-host
    Write-Host "Disabling Advertising!"
    Start-Sleep -Seconds 2
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

Function DVR1 {
    clear-host
    Write-Host "Setting GameDVR Settings!"
    Start-Sleep -Seconds 2
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "UseNexusForGameBarEnabled" -Value 0
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -PropertyType DWord -Value 0 -Force
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

Function KBM1 {
    Clear-Host
    Write-Host 'Keyboard & Mouse Tweaks!'
    Start-Sleep -Seconds 2
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\DWM' -Name 'UseDpiScaling' -Value 0
    New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\Keyboard Response' -Name 'Flags' -PropertyType String -Value '2' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\Keyboard Response' -Name 'AutoRepeatRate' -PropertyType String -Value '0' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\Keyboard Response' -Name 'AutoRepeatDelay' -PropertyType String -Value '0' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\MouseKeys' -Name 'Flags' -PropertyType String -Value '130' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\MouseKeys' -Name 'MaximumSpeed' -PropertyType String -Value '39' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\MouseKeys' -Name 'TimeToMaximumSpeed' -PropertyType String -Value '3000' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\StickyKeys' -Name 'Flags' -PropertyType String -Value '2' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\ToggleKeys' -Name 'Flags' -PropertyType String -Value '34' -Force
    New-ItemProperty -Path 'HKU\.DEFAULT\Control Panel\Mouse' -Name 'MouseSpeed' -PropertyType String -Value '0' -Force
    New-ItemProperty -Path 'HKU\.DEFAULT\Control Panel\Mouse' -Name 'MouseThreshold1' -PropertyType String -Value '0' -Force
    New-ItemProperty -Path 'HKU\.DEFAULT\Control Panel\Mouse' -Name 'MouseThreshold2' -PropertyType String -Value '0' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseSpeed' -PropertyType String -Value '0' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold1' -PropertyType String -Value '0' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold2' -PropertyType String -Value '0' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseSensitivity' -PropertyType String -Value '10' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'SmoothMouseXCurve' -PropertyType Binary -Value ([byte[]]@(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 0xCC, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x99, 0x19, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x66, 0x26, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x33, 0x33, 0x00, 0x00, 0x00, 0x00, 0x00)) -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'SmoothMouseYCurve' -PropertyType Binary -Value ([byte[]]@(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x70, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xA8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00)) -Force
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters' -Name 'KeyboardDataQueueSize' -Value 30 -Type DWord
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\mouclass\Parameters' -Name 'MouseDataQueueSize' -Value 30 -Type DWord
}

Function Misc1 {
	Write-Host "Misc Tweaks!"
	Start-Sleep -Seconds 2
	Set-ItemProperty -Path 'HKLM:\SYSTEM\ControlSet001\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\0853a681-27c8-4100-a2fd-82013e970683' -Name 'Attributes' -Value 2;
	Set-ItemProperty -Path 'HKLM:\SYSTEM\ControlSet001\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\d4e98f31-5ffe-4ce1-be31-1b38b384c009' -Name 'Attributes' -Value 2;
	New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell' -Name 'TabletMode' -PropertyType DWord -Value 0 -Force;
	New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell' -Name 'SignInMode' -PropertyType DWord -Value 1 -Force;
	New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -PropertyType DWord -Value 1 -Force;
	New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\HighContrast' -Name 'Flags' -PropertyType String -Value '4194' -Force;
	New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\SoundSentry' -Name 'Flags' -PropertyType String -Value '0' -Force;
	New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\SoundSentry' -Name 'FSTextEffect' -PropertyType String -Value '0' -Force;
	New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\SoundSentry' -Name 'TextEffect' -PropertyType String -Value '0' -Force;
	New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\SoundSentry' -Name 'WindowsEffect' -PropertyType String -Value '0' -Force;
	New-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState' -Name 'FullPath' -PropertyType DWord -Value 1 -Force;
	New-ItemProperty -Path 'HKCU:\Software\Microsoft\Multimedia\Audio' -Name 'UserDuckingPreference' -PropertyType DWord -Value 3 -Force;
	Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\VideoSettings' -Name 'VideoQualityOnBattery' -Value 1;
}

Function Services1 {
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

Function Performance1 {
	Write-Host "Performance Tweaks!"
	Start-Sleep -Seconds 2
	New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS' -Name 'EnableGR535' -PropertyType DWord -Value 0 -Force;
	Set-ItemProperty -Path 'HKCU:\Software\Microsoft\DirectX\UserGpuPreferences' -Name 'DirectXUserGlobalSettings' -Value 'SwapEffectUpgradeEnable=1;VRROptimizeEnable=0;';
	Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects' -Name 'VisualFXSetting' -Value 3;
	Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'UserPreferencesMask' -Value 0x9012038000000000;
	Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'FontSmoothing' -Value '2';
	Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'LogPixels' -Value 96;
	Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'Win8DpiScaling' -Value 1;
	Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'EnablePerProcessSystemDPI' -Value 0;
	Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'MenuShowDelay' -Value '0';
	New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers' -Name 'HwSchMode' -PropertyType DWord -Value 2 -Force;
	New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl' -Name 'Win32PrioritySeparation' -PropertyType DWord -Value 38 -Force;
	New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile' -Name 'SystemResponsiveness' -PropertyType DWord -Value 0 -Force;
	New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile' -Name 'NetworkThrottlingIndex' -PropertyType DWord -Value 10 -Force;
	New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games' -Name 'GPU Priority' -PropertyType DWord -Value 8 -Force;
	New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games' -Name 'Priority' -PropertyType DWord -Value 6 -Force;
	New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games' -Name 'Scheduling Category' -PropertyType String -Value 'High' -Force;
	Set-ItemProperty -Path 'HKLM:\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583' -Name 'ValueMax' -Value 0;
	Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling' -Name 'PowerThrottlingOff' -Value 1;
}

Function Tasks1 {
	Clear-Host
  	Write-Host "Scheduled Tasks!"
	Start-Sleep -Seconds 2
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

Function OneDrive1 {
	Clear-Host
  	Write-Host "Deleting OneDrive!"
	Start-Sleep -Seconds 2
Get-ChildItem "$env:SystemDrive\Users" | ForEach-Object {
    if (Test-Path "$($_.FullName)\OneDrive") {
        if ((Get-ChildItem "$($_.FullName)\OneDrive" -File).Count -gt 0) {
            Write-Host "Not stripping OneDrive as OneDrive files exist, exiting..."
            exit 6000
        }
    }
}

Stop-Process -Name "OneDrive" -Force -ErrorAction SilentlyContinue

$oneDrivePaths = @(
    "$env:windir\System32\OneDriveSetup.exe",
    "$env:windir\SysWOW64\OneDriveSetup.exe"
)

foreach ($path in $oneDrivePaths) {
    if (Test-Path $path) {
        & $path /uninstall | Out-Null
    }
}

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

Remove-Item -Path "$env:ProgramData\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue

Get-ChildItem "$env:SystemDrive\Users" | ForEach-Object {
    Remove-Item -Path "$($_.FullName)\AppData\Local\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$($_.FullName)\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$($_.FullName)\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" -Force -ErrorAction SilentlyContinue
}

Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SyncRootManager" | Where-Object { $_.Name -like "*OneDrive*" } | ForEach-Object {
    Remove-Item -Path $_.PSPath -Force -ErrorAction SilentlyContinue
}

Get-ScheduledTask | Where-Object { $_.TaskName -match "OneDrive Reporting Task|OneDrive Standalone Update Task" } | ForEach-Object {
    Unregister-ScheduledTask -TaskName $_.TaskName -Force -ErrorAction SilentlyContinue
}


}

Function SecurityUp1 {
    Write-Host "Configuring Windows Update for Security Updates Only..." -ForegroundColor Green
	Start-Sleep -Seconds 2

    $WURegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
    $AURegistryPath = "$WURegistryPath\AU"

    if (-not (Test-Path $WURegistryPath)) {
        New-Item -Path $WURegistryPath -Force | Out-Null
    }
    if (-not (Test-Path $AURegistryPath)) {
        New-Item -Path $AURegistryPath -Force | Out-Null
    }

    Set-ItemProperty -Path $WURegistryPath -Name "DeferFeatureUpdates" -Value 1 -Force
    Set-ItemProperty -Path $WURegistryPath -Name "DeferQualityUpdates" -Value 1 -Force
    Set-ItemProperty -Path $WURegistryPath -Name "BranchReadinessLevel" -Value 10 -Force # Set to Semi-Annual Channel (Targeted)
    Set-ItemProperty -Path $WURegistryPath -Name "DeferQualityUpdatesPeriodInDays" -Value 0 -Force

    Set-ItemProperty -Path $AURegistryPath -Name "NoAutoUpdate" -Value 1 -Force
    Set-ItemProperty -Path $AURegistryPath -Name "AUOptions" -Value 2 -Force # Notify for download/install

    $DriverPolicyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching"
    if (-not (Test-Path $DriverPolicyPath)) {
        New-Item -Path $DriverPolicyPath -Force | Out-Null
    }
    Set-ItemProperty -Path $DriverPolicyPath -Name "SearchOrderConfig" -Value 0 -Force

    Write-Host "Applying security-only updates settings..." -ForegroundColor Cyan
    Start-Process -FilePath "C:\Windows\System32\schtasks.exe" -ArgumentList "/Delete /TN \"\Microsoft\Windows\WindowsUpdate\Automatic App Update\" /F" -NoNewWindow -Wait
	Clear-Host
}





Function AIO-Tweaks {
Host.UI.RawUI.WindowTitle = "Muchility - Tweaks"
Pplan1
Clear-Host
SoftwareInstalls1
Clear-Host
Debloat1
Clear-Host
1Annoyances
Clear-Host
Wifi-Sense1
Clear-Host
Ads1
Clear-Host
DVR1
Clear-Host
KBM1
Clear-Host
Misc1
Clear-Host
Services1
Clear-Host
Performance1
Clear-Host
Tasks1
Clear-Host
OneDrive1
Clear-Host
SecurityUp1
Clear-Host
Clean-TempFolders
}

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!





Function WinUp-Sec {
    Write-Host "Configuring Windows Update for Security Updates Only..." -ForegroundColor Green

    # Define registry paths for Windows Update configurations
    $WURegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
    $AURegistryPath = "$WURegistryPath\AU"

    # Ensure the registry keys exist
    if (-not (Test-Path $WURegistryPath)) {
        New-Item -Path $WURegistryPath -Force | Out-Null
    }
    if (-not (Test-Path $AURegistryPath)) {
        New-Item -Path $AURegistryPath -Force | Out-Null
    }

    # Disable automatic updates except for security updates
    Set-ItemProperty -Path $WURegistryPath -Name "DeferFeatureUpdates" -Value 1 -Force
    Set-ItemProperty -Path $WURegistryPath -Name "DeferQualityUpdates" -Value 1 -Force
    Set-ItemProperty -Path $WURegistryPath -Name "BranchReadinessLevel" -Value 10 -Force # Semi-Annual Channel (Targeted)
    Set-ItemProperty -Path $WURegistryPath -Name "DeferQualityUpdatesPeriodInDays" -Value 0 -Force

    # Configure AU settings for manual control
    Set-ItemProperty -Path $AURegistryPath -Name "NoAutoUpdate" -Value 1 -Force
    Set-ItemProperty -Path $AURegistryPath -Name "AUOptions" -Value 2 -Force # Notify for download/install

    # Disable driver updates via Windows Update
    $DriverPolicyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching"
    if (-not (Test-Path $DriverPolicyPath)) {
        New-Item -Path $DriverPolicyPath -Force | Out-Null
    }
    Set-ItemProperty -Path $DriverPolicyPath -Name "SearchOrderConfig" -Value 0 -Force

    # Optimize Update Settings for Security Updates Only
    Write-Host "Applying security-only updates settings..." -ForegroundColor Cyan
    Start-Process -FilePath "C:\Windows\System32\schtasks.exe" -ArgumentList "/Delete /TN \"\Microsoft\Windows\WindowsUpdate\Automatic App Update\" /F" -NoNewWindow -Wait

    Write-Host "Security update configuration complete. Restart your computer for full effect." -ForegroundColor Green
}

Function WinUp-Dis {
    Write-Host "Disabling Windows Update..." -ForegroundColor Red

    # Disable Windows Update Services
    Stop-Service -Name wuauserv -Force
    Set-Service -Name wuauserv -StartupType Manual

    # Disable all automatic updates via registry
    $WURegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
    $AURegistryPath = "$WURegistryPath\AU"

    if (-not (Test-Path $WURegistryPath)) {
        New-Item -Path $WURegistryPath -Force | Out-Null
    }
    if (-not (Test-Path $AURegistryPath)) {
        New-Item -Path $AURegistryPath -Force | Out-Null
    }

    Set-ItemProperty -Path $AURegistryPath -Name "NoAutoUpdate" -Value 1 -Force
    Set-ItemProperty -Path $AURegistryPath -Name "AUOptions" -Value 1 -Force # Never check for updates

    Write-Host "Windows Update has been disabled. Restart your computer for full effect." -ForegroundColor Red
}

Function WinUp-Ena {
    Write-Host "Enabling Windows Update..." -ForegroundColor Green

    # Enable Windows Update Services
    Start-Service -Name wuauserv
    Set-Service -Name wuauserv -StartupType Automatic

    # Enable all automatic updates via registry
    $WURegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
    $AURegistryPath = "$WURegistryPath\AU"

    if (-not (Test-Path $WURegistryPath)) {
        New-Item -Path $WURegistryPath -Force | Out-Null
    }
    if (-not (Test-Path $AURegistryPath)) {
        New-Item -Path $AURegistryPath -Force | Out-Null
    }

    Set-ItemProperty -Path $AURegistryPath -Name "NoAutoUpdate" -Value 0 -Force
    Set-ItemProperty -Path $AURegistryPath -Name "AUOptions" -Value 4 -Force # Auto download and install updates

    Write-Host "Windows Update has been enabled. Restart your computer for full effect." -ForegroundColor Green
}





# Below is Check Functions

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

# Function to update all available apps using choco
Function Choco-Update-All {
    # Check if Chocolatey is installed
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        
        # Enable global confirmation for silent updates
        choco feature enable -n allowGlobalConfirmation
        
        # Update all installed packages with Chocolatey
        choco upgrade all -force -y
    } else {
        Write-Host "Chocolatey is not installed."
        Start-Sleep -Seconds 1
    }
}

# Function to check internet connection
Function cInternet {
    try {
        # Attempt to ping a reliable host (Google DNS)
        $pingResult = Test-Connection -ComputerName "8.8.8.8" -Count 1 -Quiet
        if ($pingResult) {
            return "Online"
        } else {
            return "Offline"
        }
    } catch {
        return "Offline"  # Return "Offline" if there's an error
    }
}

$cInternet = cInternet
$color = if ($cInternet -eq "Online") { "Green" } else { "DarkGray" }

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!






do {
    Muchility-Menu
    $key = [System.Console]::ReadKey($true).KeyChar
    switch ($key) {
		"0" { Create-RestorePoint }
        "1" { Tweaks }
        "2" { BCD-Tweaks }
        "3" { Install-Choco } 
        "4" { Update-Apps } 
		"5" { Install-Brave }  
        "6" { WinUp-Menu } 
		"7" { Activate-Win }
		"8" { cUpdate-Drivers }
		"9" { cSystem-Repairs }
		"T" { Clean-TempFolders }
		"C" { Remove-Choco }
		"M" { Muchility-Menu }
        default { Break }
    }
} while ($key -ne "0")
