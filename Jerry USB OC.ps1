$GLOBAL_INTERVAL = 0x0

$INDIVIDUAL_INTERVALS = @{}

$RWE_PATH = "C:\Tweaks\Rw.exe"

function GetValueFromAddress($address) {
    
    $address = "0x" + $address.ToString("X2")

    $stdout = & $RWE_PATH /Min /NoLogo /Stdout /Command="R32 $address" | Out-String
    $split_string = $stdout -split " "
    return [int]$split_string[-1]
}

function Is-Admin() {
    $current_principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $current_principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function main() {
    if (-not (Is-Admin)) {
        Write-Host "error: administrator privileges required"
        return 1
    }

    if (-not (Test-Path $RWE_PATH -PathType Leaf)) {
        Write-Host "error: invalid path"
        return 1
    }

    
    Stop-Process -Name "Rw" -ErrorAction SilentlyContinue

    $device_map = @{}

    
    foreach ($i in Get-CimInstance Win32_PNPAllocatedResource) {
        $device_ID = $i.Dependent.DeviceID
        $physical_address = $i.Antecedent.StartingAddress

        if ($device_ID -and $physical_address) {
            $device_map[$device_ID] = $physical_address
        }
    }

    foreach ($xhci_controller in Get-WmiObject Win32_USBController) {
        $device_ID = $xhci_controller.DeviceID

        
        if (-not $device_map.Contains($device_ID)) {
            continue
        }

        Write-Host $xhci_controller.Description

        $capability_address = $device_map[$device_ID]
        $HCSPARAMS_value = GetValueFromAddress($capability_address + 0x4)
        $HCSPARAMS_bitmask = [Convert]::ToString($HCSPARAMS_value, 2)
        $max_intrs = [Convert]::ToInt32($HCSPARAMS_bitmask.Substring($HCSPARAMS_bitmask.Length - 16, 8), 2)
        $RTSOFF_value = GetValueFromAddress($capability_address + 0x18)
        $runtime_address = $capability_address + $RTSOFF_value

        $desired_interval = $GLOBAL_INTERVAL

        foreach ($hwid in $INDIVIDUAL_INTERVALS.Keys) {
            if ($device_ID -match $hwid) {
                $desired_interval = $INDIVIDUAL_INTERVALS[$hwid]
            }
        }

        for ($i = 0; $i -lt $max_intrs; $i++) {
            
            $interrupter_address = "{0:X}" -f ($runtime_address + 0x24 + (0x20 * $i))
            & $RWE_PATH /Min /NoLogo /Stdout /Command="W32 0x$interrupter_address $desired_interval" | Write-Host
        }

        
        Write-Host
    }

    return 0
}

exit main
