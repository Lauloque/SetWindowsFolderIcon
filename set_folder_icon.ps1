# SPDX-License-Identifier: GPL-3.0-or-later
# set_folder_icon.ps1
param(
    [string]$imagePath
)

$ErrorActionPreference = 'Stop'

# Resolve full path and target folder
$imagePath = (Resolve-Path $imagePath).Path
$folderPath = Split-Path $imagePath -Parent
$iconPath = Join-Path $folderPath "icon.ico"
$desktopIniPath = Join-Path $folderPath "desktop.ini"

# delete icon and ini files
if (Test-Path $iconPath) {
    Remove-Item $iconPath -Force
}
if (Test-Path $desktopIniPath) {
    Remove-Item $desktopIniPath -Force
}

# Convert image to .ico using ImageMagick
$magickArgs = @(
    "$imagePath",
    "-resize", "512x512",
    "-background", "none",
    "-gravity", "center",
    "-extent", "512x512",
    "-write", "mpr:base",
    "(", "mpr:base", "-resize", "512x512", ")",
    "(", "mpr:base", "-resize", "256x256", ")",
    "(", "mpr:base", "-resize", "128x128", ")",
    "(", "mpr:base", "-resize", "64x64", ")",
    "(", "mpr:base", "-resize", "32x32", ")",
    "(", "mpr:base", "-resize", "16x16", ")",
    "-delete", "0",
    "-alpha", "on",
    "$iconPath"
)

& magick @magickArgs

# Write desktop.ini
@"
[.ShellClassInfo]
IconResource=icon.ico,0
"@ | Set-Content -Encoding UTF8 "$desktopIniPath"

# Set folder attributes (system + readonly)
attrib +s +r "$folderPath"

# Set desktop.ini as hidden and system
attrib +s +h "$desktopIniPath"
attrib +h "$iconPath"

# Optional: notify user
[System.Windows.Forms.MessageBox]::Show("Icon set for folder:`n$folderPath", "Success")
Start-Sleep -Milliseconds 2000