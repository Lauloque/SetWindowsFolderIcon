# SPDX-License-Identifier: GPL-3.0-or-later
# uninstall_context_menu.ps1
$extensions = @(".jpg", ".jpeg", ".png", ".webp")

foreach ($ext in $extensions) {
    $keyPath = "HKCU:\Software\Classes\SystemFileAssociations\$ext\shell\SetAsFolderIcon"
    Remove-Item -Path $keyPath -Recurse -ErrorAction SilentlyContinue
}

Write-Host "Context menu entry removed."
