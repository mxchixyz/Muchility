Function FF-Create-Restore-Point {
    Checkpoint-Computer -Description "Before Muchility" -RestorePointType "MODIFY_SETTINGS"
}

Function FF-Set-Restore-Point-Frequency {
    try {
        $registryPath = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore"
        $valueName = "SystemRestorePointCreationFrequency"
        $valueData = 2

        if (-not (Test-Path $registryPath)) {
            throw "Registry path $registryPath does not exist."
        }

        Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Force > $null 2>&1
    } catch {
        # Handle failure silently
    }
}

Function FF-Check-Restore-Point-Status {
    $vssOutput = vssadmin list shadowstorage

    if ($vssOutput -match "No shadow copies are available") {
        return $false
    } else {
        return $true
    }
}

Function FF-Enable-Restore-Points {
    try {
        Enable-ComputerRestore -Drive "C:\"  # Modify the drive as needed
        return $true
    } catch {
        return $false
    }
}


FF-Check-Restore-Point-Status
FF-Set-Restore-Point-Frequency
FF-Enable-Restore-Points
FF-Create-Restore-Point