Function Activate-Win {
    # Define paths
    $url = "https://www.dropbox.com/scl/fi/u2tzx77rfji79mpqa54su/Activate.cmd?rlkey=uys7zaez0dxeu3di7znwq2zty&st=7ed9il2y&dl=1"
    $tempDir = "C:\_temp"
    $filePath = [System.IO.Path]::Combine($tempDir, "Activate.cmd")
    $shortcutPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), "Activate Windows.lnk")

    # Ensure the temporary directory exists
    If (-not (Test-Path $tempDir)) {
        New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
    }

    # Download the file
    Invoke-WebRequest -Uri $url -OutFile $filePath -ErrorAction SilentlyContinue

    # Create the shortcut
    $WScriptShell = New-Object -ComObject WScript.Shell
    $shortcut = $WScriptShell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = "cmd.exe"
    $shortcut.Arguments = "/c `"$filePath`" /HWID"
    $shortcut.WorkingDirectory = $tempDir
    $shortcut.IconLocation = "C:\Windows\System32\cmd.exe,0"
    $shortcut.Save()

    # Run the shortcut as administrator
    Start-Process "cmd.exe" -ArgumentList "/c `"$filePath`" /HWID" -WorkingDirectory $tempDir -Verb RunAs
}
Activate-Win