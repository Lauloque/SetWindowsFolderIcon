# SPDX-License-Identifier: GPL-3.0-or-later
# setup_context_menu.ps1
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$handlerScript = Join-Path $scriptPath "set_folder_icon.ps1"

# Escape double quotes and backslashes
$escapedPath = $handlerScript.Replace('\', '\\')

$command = "powershell.exe -ExecutionPolicy Bypass -File `"$escapedPath`" `"%1`""

$extensions = @(".bmp", ".gif", ".jpg", ".jpeg", ".png", ".tiff", ".webp")

foreach ($ext in $extensions) {
    $keyPath = "HKCU:\Software\Classes\SystemFileAssociations\$ext\shell\SetAsFolderIcon"
    New-Item -Path $keyPath -Force | Out-Null
    Set-ItemProperty -Path $keyPath -Name "(default)" -Value "Set as Folder Icon"
    Set-ItemProperty -Path $keyPath -Name "Icon" -Value "shell32.dll,3"

    $cmdPath = "$keyPath\command"
    New-Item -Path $cmdPath -Force | Out-Null
    Set-ItemProperty -Path $cmdPath -Name "(default)" -Value $command
}

Write-Host "Context menu added. Right-click an image to set it as the folder's icon."
