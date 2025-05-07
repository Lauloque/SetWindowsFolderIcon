# SPDX-License-Identifier: GPL-3.0-or-later
# Reset Windows Explorer icon cache (PowerShell version)

Add-Type -AssemblyName PresentationFramework

$iconCache1 = "$env:LOCALAPPDATA\IconCache.db"
$iconCache2 = "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\iconcache*"

$caption = "Reset Icon Cache"
$message = @"
This will temporarily close all File Explorer windows
and delete the Windows icon cache.

Please SAVE ALL WORK before continuing.

Do you want to proceed?
"@

$result = [System.Windows.MessageBox]::Show($message, $caption, "YesNo", "Warning")

if ($result -ne "Yes") {
    Write-Host "Operation cancelled by user."
    exit
}

Write-Host "`nAttempting to delete icon cache..."

# Optional: call ie4uinit to ensure correct environment
Start-Process -NoNewWindow -FilePath "ie4uinit.exe" -ArgumentList "-show"

# Kill explorer
Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# Delete cache files
Remove-Item -Path $iconCache1 -Force -ErrorAction SilentlyContinue
Remove-Item -Path $iconCache2 -Force -ErrorAction SilentlyContinue

# Restart explorer
Start-Process "explorer.exe"

[System.Windows.MessageBox]::Show("Icon cache cleared. Explorer has restarted.", "Done")
