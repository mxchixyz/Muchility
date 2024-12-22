#╔══╗══╗╔═╗═╗╔═══╗╔═╗╔═╗╔═╗"
#║*   *║║*║*║║*║*║║*╚╝*║╠-╣"
#║ ║ ║ ║║*║*║║*╚═╣║*╔╗*║║*║"
#╚═╩═╩═╝╚═══╝╚═══╝╚═╝╚═╝╚═╝"

$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.WindowTitle = "Lite - Updater"


# Check if ps2exe is installed
function Check-PS2EXE {
    try {
        Get-Command ps2exe -ErrorAction Stop | Out-Null
        return $true
    } catch {
        return $false
    }
}

# Install ps2exe if missing
function Install-PS2EXE {
    Install-Module -Name ps2exe -Force -Scope CurrentUser
}

# Compile and run the script
function Compile-And-Run {
    $TempDir = "C:\_temp"
    if (!(Test-Path -Path $TempDir)) { New-Item -ItemType Directory -Path $TempDir | Out-Null }

    $RunScriptUrl = "https://raw.githubusercontent.com/Muchiiix/Muchility/main/run.ps1"
    $IconUrl = "https://raw.githubusercontent.com/Muchiiix/Muchility/main/Muchi.ico"
    $RunScriptPath = Join-Path $TempDir "run.ps1"
    $IconPath = Join-Path $TempDir "Muchi.ico"
    $OutputExe = Join-Path $TempDir "Muchility.exe"
    $DesktopPath = [Environment]::GetFolderPath("Desktop")
    $FinalExePath = Join-Path $DesktopPath "Muchility.exe"

    Invoke-WebRequest -Uri $RunScriptUrl -OutFile $RunScriptPath -UseBasicParsing
    Invoke-WebRequest -Uri $IconUrl -OutFile $IconPath -UseBasicParsing
    ps2exe $RunScriptPath $OutputExe -iconFile $IconPath
    Move-Item -Path $OutputExe -Destination $FinalExePath -Force
    Remove-Item -Path $TempDir -Recurse -Force
    Start-Process -FilePath $FinalExePath
}

# Main execution
if (-not (Check-PS2EXE)) { Install-PS2EXE }
Compile-And-Run

