#╔══╗══╗╔═╗═╗╔═══╗╔═╗╔═╗╔═╗"
#║*   *║║*║*║║*║*║║*╚╝*║╠-╣"
#║ ║ ║ ║║*║*║║*╚═╣║*╔╗*║║*║"
#╚═╩═╩═╝╚═══╝╚═══╝╚═╝╚═╝╚═╝"

set-executionpolicy unrestricted


#Tweaks + RunAll

Function TwSwInstalls {
        # Create and set DenyDeviceIDs registry key
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions" -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions" -Name "DenyDeviceIDs" -Value 1

        # Create and set DeviceSetupManager registry key
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceSetup" -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceSetup" -Name "DeviceSetupManager" -Value 0

        # Create and set ExcludeWUDriversInQualityUpdate registry key
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Value 1

        # Create and set PreventDeviceMetadataFromNetwork registry key
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Value 1

        # Create DeviceInstaller key if it does not exist, then set DisableCoInstallers value
        if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceInstaller")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceInstaller" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceInstaller" -Name "DisableCoInstallers" -Value 1

        # Set SearchOrderConfig registry key
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -Value 0
}

Function TwOneDrive {
Get-ChildItem "$env:SystemDrive\Users" | ForEach-Object {
    if (Test-Path "$($_.FullName)\OneDrive") {
        if ((Get-ChildItem "$($_.FullName)\OneDrive" -File).Count -gt 0) {
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

Function TwWiFiSense {
    New-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -PropertyType DWord -Value 0 -Force
    New-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -PropertyType DWord -Value 0 -Force
}

Function TwAds {
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

Function TwDVR {
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

Function TwGameMode {
	Set-ItemProperty -Path 'HKCU:\Software\Microsoft\GameBar' -Name 'AutoGameModeEnabled' -Value 1;
}

Function TwKBM {
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\DWM' -Name 'UseDpiScaling' -Value 0
    New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\Keyboard Response' -Name 'Flags' -PropertyType String -Value '2' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\Keyboard Response' -Name 'AutoRepeatRate' -PropertyType String -Value '0' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\Keyboard Response' -Name 'AutoRepeatDelay' -PropertyType String -Value '0' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\MouseKeys' -Name 'Flags' -PropertyType String -Value '130' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\MouseKeys' -Name 'MaximumSpeed' -PropertyType String -Value '39' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\MouseKeys' -Name 'TimeToMaximumSpeed' -PropertyType String -Value '3000' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\StickyKeys' -Name 'Flags' -PropertyType String -Value '2' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\ToggleKeys' -Name 'Flags' -PropertyType String -Value '34' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseSpeed' -PropertyType String -Value '0' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold1' -PropertyType String -Value '0' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold2' -PropertyType String -Value '0' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseSensitivity' -PropertyType String -Value '10' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'SmoothMouseXCurve' -PropertyType Binary -Value ([byte[]]@(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 0xCC, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x99, 0x19, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x66, 0x26, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x33, 0x33, 0x00, 0x00, 0x00, 0x00, 0x00)) -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'SmoothMouseYCurve' -PropertyType Binary -Value ([byte[]]@(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x70, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xA8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00)) -Force
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters' -Name 'KeyboardDataQueueSize' -Value 30 -Type DWord
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\mouclass\Parameters' -Name 'MouseDataQueueSize' -Value 30 -Type DWord
}

Function TwMuchiPowerPlan {
    $downloadUrl = "https://github.com/Muchiiix/Muchility/raw/refs/heads/main/Muchi.pow"
    $destinationPath = "C:\_temp\Muchi.pow"
    $targetDir = Split-Path -Path $destinationPath

    # Check if a power plan containing "Muchi" already exists
    $schemes = powercfg /l
    if ($schemes -match "Muchi") {
        MuchiDMB "Muchi Power Plan Already Exists"
        return
    }

    # Create target directory if it doesn't exist
    if (!(Test-Path -Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir -Force
    }

    # Download and import the power plan
    Invoke-WebRequest -Uri $downloadUrl -OutFile $destinationPath
    powercfg -import $destinationPath

    # Set the imported plan as active
    $schemes = powercfg /l
    $schemeGuid = $schemes | Select-String -Pattern "Muchi" | ForEach-Object { $_.ToString().Split()[3] }
    if ($schemeGuid) {
        powercfg /s $schemeGuid
    }
}

Function TwOwnershipContext {
    $regFilePath = "C:\_temp\takeownership.reg"
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
"IsolatedCommand"="powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%1\\\" && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l & pause' -Verb runAs\""
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
if (-not (Test-Path "C:\_temp")) { New-Item -Path "C:\" -Name "_temp" -ItemType Directory }
$regContent | Out-File -FilePath $regFilePath -Force
Start-Process "regedit.exe" -ArgumentList "/s $regFilePath" -WindowStyle Hidden
Remove-Item -Path $regFilePath -Force
}

Function TwServices {
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

Function TwPerformance {
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

Function TwScheduledTasks {
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

Function TwRunAll {
TwSwInstalls
TwOneDrive
TwWiFiSense
TwAds
TwDVR
TwGameMode
TwKBM
TwMuchiPowerPlan
TwOwnershipContext
TwServices
TwPerformance
TwScheduledTasks
MuchiDMB "All Tweaks Applied"
}

TwRunAll
