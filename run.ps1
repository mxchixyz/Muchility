#╔══╗══╗╔═╗═╗╔═══╗╔═╗╔═╗╔═╗"
#║*   *║║*║*║║*║*║║*╚╝*║╠-╣"
#║ ║ ║ ║║*║*║║*╚═╣║*╔╗*║║*║"
#╚═╩═╩═╝╚═══╝╚═══╝╚═╝╚═╝╚═╝"


# Load required assembly
Add-Type -AssemblyName System.Windows.Forms

# Define button parameters
$buttonWidth = 120
$buttonHeight = 40
$paddingX = 20
$paddingY = 20
$columns = 2
$rows = 4  # Adjusting to 8 buttons, you can tweak as needed

# Calculate window size based on buttons
$formWidth = ($columns * ($buttonWidth + $paddingX)) + $paddingX
$formHeight = ($rows * ($buttonHeight + $paddingY)) + $paddingY + 40

# Create a new form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Muchility 2.0"
$form.Size = New-Object System.Drawing.Size($formWidth, $formHeight)

# Apply dark mode colors
$form.BackColor = [System.Drawing.Color]::FromArgb(45, 45, 48)  # Dark background color
$form.ForeColor = [System.Drawing.Color]::White  # Light text color

# Make the form fixed size (no resizing allowed)
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog  # Prevent resizing
$form.MaximizeBox = $false  # Disable maximize button
$form.MinimizeBox = $false  # Disable minimize button
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen  # Center the window






# All Functions


#Tweaks, Individual + RunAll


Function 1SoftwareInstalls {
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

	Start-Sleep -Seconds 2
}

Function 1Debloat {
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

Function Ads1 {
    
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

Function 1DVR {
    
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
    New-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseSpeed' -PropertyType String -Value '0' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold1' -PropertyType String -Value '0' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold2' -PropertyType String -Value '0' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseSensitivity' -PropertyType String -Value '10' -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'SmoothMouseXCurve' -PropertyType Binary -Value ([byte[]]@(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 0xCC, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x99, 0x19, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x66, 0x26, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x33, 0x33, 0x00, 0x00, 0x00, 0x00, 0x00)) -Force
    New-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'SmoothMouseYCurve' -PropertyType Binary -Value ([byte[]]@(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x70, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xA8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00)) -Force
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters' -Name 'KeyboardDataQueueSize' -Value 30 -Type DWord
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\mouclass\Parameters' -Name 'MouseDataQueueSize' -Value 30 -Type DWord
}

Function Services1 {
	
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

Function Performance1 {
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

Function 1Drive {
	
	Start-Sleep -Seconds 2
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

Function SecurityUp1 {
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

    Start-Process -FilePath "C:\Windows\System32\schtasks.exe" -ArgumentList "/Delete /TN \"\Microsoft\Windows\WindowsUpdate\Automatic App Update\" /F" -NoNewWindow -Wait
	
}

Function cRunAll {
1SoftwareInstalls
1Debloat
Ads1
1DVR
KBM1
Services1
Performance1
Tasks1
1Drive
SecurityUp1
Start-Sleep Seconds 2

}



# Functions For Other Buttons

Function Activate-Win {
    $Host.UI.RawUI.WindowTitle = "Muchility - Getting Activation Script"
    
	
    # Define paths
    $url = "https://www.dropbox.com/scl/fi/u2tzx77rfji79mpqa54su/Activate.cmd?rlkey=uys7zaez0dxeu3di7znwq2zty&st=7ed9il2y&dl=1"
    $filePath = "C:\Activate-Windows\Activate.cmd"
    $shortcutPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), "Activate Windows.lnk")
    
	

    # Create directory if it doesn't exist
    If (-not (Test-Path "C:\Activate-Windows")) {
        New-Item -ItemType Directory -Path "C:\Activate-Windows"
    }
	


    # Download the file
    Invoke-WebRequest -Uri $url -OutFile $filePath
    
	
    # Create shortcut
    $WScriptShell = New-Object -ComObject WScript.Shell
    $shortcut = $WScriptShell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $filePath
    $shortcut.Arguments = "/HWID"  # Add /HWID argument
    $shortcut.WorkingDirectory = "C:\Activate-Windows"
    $shortcut.IconLocation = "C:\Windows\System32\cmd.exe, 0"  # Icon for shortcut
    $shortcut.Save()
    
	
    # Run the shortcut as administrator
    Start-Process $shortcutPath -Verb RunAs
    
	
    Return
}

Function Win-Sec-Upd {


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

    Start-Process -FilePath "C:\Windows\System32\schtasks.exe" -ArgumentList "/Delete /TN \"\Microsoft\Windows\WindowsUpdate\Automatic App Update\" /F" -NoNewWindow -Wait
}

Function cSystem-Repairs {
    # Run the CMD as Administrator and execute the repairs
    $cmdArguments = @"
    dism.exe /Online /Cleanup-Image /ScanHealth
    dism.exe /Online /Cleanup-Image /RestoreHealth

    sfc.exe /scannow

    chkdsk C: /F /R /X
"@
    
    # Launch the command in an elevated CMD window
    Start-Process "cmd.exe" -ArgumentList "/K $cmdArguments" -Verb RunAs
}

Function mInstall-Choco {
	$Host.UI.RawUI.WindowTitle = "Muchility - Installing Choco"
    
	
    # Check if Chocolatey is already installed
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        Start-Sleep -Seconds 2
        return  # Exit the function if already installed
    }
    else {
        Start-Sleep -Seconds 2
        Set-ExecutionPolicy Bypass -Scope Process -Force
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        return  # Exit the function after installation
    }
}

Function mRemove-Choco {
	    # Delete existing Chocolatey directories if found
    $chocoDir = "C:\ProgramData\chocolatey"
    $chocoCacheDir = "C:\ProgramData\ChocolateyHttpCache"
    
    if (Test-Path -Path $chocoDir) {
        Remove-Item -Recurse -Force -Path $chocoDir
    }

    if (Test-Path -Path $chocoCacheDir) {
        Remove-Item -Recurse -Force -Path $chocoCacheDir
    }

}

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
	
    # Clean C:\Windows\Temp
    Remove-TempFolder $windowsTemp
	
    # Clean %appdata%\Local\Temp
    Remove-TempFolder $appDataTemp
	
    # Clean C:\_temp
    Remove-TempFolder $customTemp1
	
}

Function cUpdate-Drivers {
    $Host.UI.RawUI.WindowTitle = "Muchility - Updating Drivers"
    
	
    # Define paths and URLs
    $sdiUrl = "https://sdi-tool.org/releases/SDI_R2408.zip"  # Replace with actual SDI URL
    $sdiPath = "C:\_SDI"
    $zipFilePath = "$env:USERPROFILE\Downloads\SDI.zip"
	


    # Step 1: Ensure clean slate by deleting existing folder and zip if they exist
    try {
        if (Test-Path $sdiPath) { Remove-Item -Path $sdiPath -Recurse -Force }
        if (Test-Path $zipFilePath) { Remove-Item -Path $zipFilePath -Force }
    } catch {
    }
	


    # Step 2: Download the SDI zip file
    try {
        Invoke-WebRequest -Uri $sdiUrl -OutFile $zipFilePath -UseBasicParsing
    } catch {
        return
    }
	


    # Step 3: Extract the zip to the desired location
    try {
        Expand-Archive -Path $zipFilePath -DestinationPath $sdiPath -Force
    } catch {
        return
    }
	


    # Step 4: Delete the zip file after extraction
    try {
        Remove-Item -Path $zipFilePath -Force
    } catch {
    }
	


    # Step 5: Locate the SDI_auto.bat file
    try {
        $batchFile = Get-ChildItem -Path $sdiPath -Filter "SDI_auto.bat" -Recurse | Select-Object -First 1
        if (-not $batchFile) {
            return
        }
    } catch {
        return
    }
	


    # Step 6: Launch the SDI_auto.bat file
    try {
        Start-Process -FilePath $batchFile.FullName
		Start-Sleep -Seconds 10
    } catch {
    }
}



#Funtion For Dark Mode Message Boxes

Function Show-DarkModeMessageBox {
    param(
        [string]$message
    )

    # Create a new form with a title bar and close button
    $form = New-Object System.Windows.Forms.Form
    $form.Size = New-Object System.Drawing.Size(300, 100)  # Set the size of the form
    $form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
    $form.Text = ""  # Leave the title bar blank
    $form.BackColor = [System.Drawing.Color]::FromArgb(45, 45, 48)  # Dark background
    $form.ForeColor = [System.Drawing.Color]::White  # White text color

    # Make the form non-resizable and remove minimize/maximize buttons
    $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog  # Fixed border (with title)
    $form.MaximizeBox = $false  # Disable maximize button
    $form.MinimizeBox = $false  # Disable minimize button

    # Add the message label
    $label = New-Object System.Windows.Forms.Label
    $label.Text = $message
    $label.ForeColor = [System.Drawing.Color]::White
    $label.AutoSize = $true  # Let the label resize according to text
    $label.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter  # Center the text inside the label

    # Add the label to the form
    $form.Controls.Add($label)

    # Dynamically update label position on form resize
    $form.Add_Shown({
        # Ensure the label is always centered
        $label.Location = New-Object System.Drawing.Point(
            [math]::Round(($form.ClientSize.Width - $label.Width) / 2),  # Center horizontally
            [math]::Round(($form.ClientSize.Height - $label.Height) / 2)  # Center vertically
        )
    })

    # Dynamically update label position on form resize
    $form.Add_Resize({
        # Ensure the label is always centered when resizing
        $label.Location = New-Object System.Drawing.Point(
            [math]::Round(($form.ClientSize.Width - $label.Width) / 2),  # Center horizontally
            [math]::Round(($form.ClientSize.Height - $label.Height) / 2)  # Center vertically
        )
    })

    # Show the form
    $form.ShowDialog()
}



# Functions aka Buttons

Function Tweaks1 {

Show-DarkModeMessageBox "May Freeze! Don't Panic."


cRunAll > $null 2>&1


Show-DarkModeMessageBox "Tweaks Applied!"
}

Function Activate-Windows {

Show-DarkModeMessageBox "Activating Windows"
	Activate-Win > $null 2>&1
}

Function Windows-Update {
	Win-Sec-Upd > $null 2>&1

Show-DarkModeMessageBox "Security Only Updates Enabled!"
}

Function Repair-System {

Show-DarkModeMessageBox "Starting System Repairs!"
	cSystem-Repairs > $null 2>&1
}

Function Install-Choco {
	mInstall-Choco > $null 2>&1

Show-DarkModeMessageBox "Choco Installed"
}

Function Uninstall-Choco {
	mRemove-Choco > $null 2>&1

Show-DarkModeMessageBox "Choco Uninstalled"
}

Function Clear-Temp {
	Clean-TempFolders > $null 2>&1

Show-DarkModeMessageBox "Temp Files/Folders Cleared"


}

Function Update-Drivers {

Show-DarkModeMessageBox "Drivers Updating via SDI"
	cUpdate-Drivers > $null 2>&1
}

# Helper function to add buttons with custom function links
Function Add-Button {
    param (
        [string]$text,
        [int]$x,
        [int]$y,
        [scriptblock]$function
    )
    $button = New-Object System.Windows.Forms.Button
    $button.Text = $text
    $button.Size = New-Object System.Drawing.Size($buttonWidth, $buttonHeight)
    $button.Location = New-Object System.Drawing.Point($x, $y)
    $button.Add_Click($function)  # Link the function to the button's click event
    $form.Controls.Add($button)
}

# Add buttons dynamically with custom functions
for ($i = 0; $i -lt 8; $i++) {
    $col = $i % $columns
    $row = [math]::Floor($i / $columns)
    $x = ($col * ($buttonWidth + $paddingX)) + $paddingX
    $y = ($row * ($buttonHeight + $paddingY)) + $paddingY
    
    # Button names and corresponding functions
    $function = switch ($i) {
        0 { { Tweaks1 } }  # Link Tweaks1 to the first button
        1 { { Activate-Windows } }
        2 { { Windows-Update } }
        3 { { Repair-System } }
        4 { { Install-Choco } }
        5 { { Uninstall-Choco } }
        6 { { Clear-Temp } }
        7 { { Update-Drivers } }
    }

    # Button text (name for each button)
    $buttonName = switch ($i) {
        0 { "Run Tweaks" }
        1 { "Activate Windows" }
        2 { "Windows Update" }
        3 { "Repair System" }
        4 { "Install Choco" }
        5 { "Uninstall Choco" }
        6 { "Clear Temp" }
        7 { "Update Drivers" }
    }

    Add-Button -text $buttonName -x $x -y $y -function $function
}

# Display the form
[void]$form.ShowDialog()
