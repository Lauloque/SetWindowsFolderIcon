# SetWindowsFolderIcon

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/H2H818FHX)

A tiny Windows tool to add a right-click menu entry that lets you set any image as the **current folder’s icon**.

[![GPL-3.0](https://img.shields.io/badge/License-GPL%203.0-blue.svg?style=for-the-badge)](https://opensource.org/licenses/GPL-3.0)

---

## 🎯 What It Does

Right-click on an image file (BMP, GIF, JPG, JPEG, PNG, TIFF, WEBP) and choose **"Set as Folder Icon"**.  
This script will:

- Convert the image into a `.ico` file using [ImageMagick](https://imagemagick.org/),
- Write a `desktop.ini` file with the necessary icon settings,
- Set the folder’s attributes so Windows recognizes the icon.

The change is visible in File Explorer (you may need to refresh or reopen the window).

---

## 🧩 Requirements

- **Windows 10 or 11**
- **PowerShell** (built-in)
- **ImageMagick** installed and available in your system's `PATH`

### 🛠 Installing ImageMagick

You can download ImageMagick from their website:  
👉 [imagemagick.org/script/download.php#windows](https://imagemagick.org/script/download.php#windows)

Or install it from a terminal with one of these (admin rights may be needed):

```shell
winget install ImageMagick.Q16-HDRI
scoop install main/imagemagick
choco install imagemagick
```

To verify it’s working, try this:

```shell
Copy
Edit
magick logo: logo.gif
magick identify logo.gif
```

## 🚀 Setup

1. **Download this folder** and place it somewhere safe on your computer;

2. **Right-click** `setup_context_menu.ps1` and select **Run With PowerShell** (might require administrative rights)  
    This registers the context menu for supported image types.

> [!NOTE]
> 
> 🔁 You can move the folder later, but you’ll need to re-run `setup_context_menu.ps1` if you do.  
> This is because the right-click menu points to the script’s current location.

---

## ✅ Usage

- Right-click an image → choose **Set as Folder Icon**.

- The icon file (`icon.ico`) and configuration (`desktop.ini`) are saved in the same folder as the image.

That’s it! Your folder will now show the custom icon.

### ❌ To Remove a Folder Icon

Just delete the `icon.ico` or `desktop.ini` file from the folder.

### 🔧 To Uninstall the Context Menu

Right-click `uninstall_context_menu.ps1` → **Run With PowerShell** (might require administrative rights).

---

## 📦 File Overview

| File                         | Purpose                                 |
| ---------------------------- | --------------------------------------- |
| `set_folder_icon.ps1`        | Main script: converts image & sets icon |
| `setup_context_menu.ps1`     | Adds the right-click context menu       |
| `uninstall_context_menu.ps1` | Removes the context menu                |

---

<details>
<summary>🔍 Advanced Notes</summary>

### 📁 What Happens Internally?

- `magick` converts the image to `icon.ico` using multi-resolution settings (64, 128, 256).

- A `desktop.ini` file is written with the following contents:
  
  ini
  
  CopyEdit
  
  `[.ShellClassInfo] IconResource=icon.ico,0`

- The script marks the folder with `+s +r` attributes so that Windows uses the `.ini` file.

- The icon and `.ini` are marked as hidden/system files so they don't clutter the view.

### 🧠 Existing Files?

If `icon.ico` or `desktop.ini` already exists, they will be overwritten without prompting.  
This avoids clutter and ensures a clean overwrite.

### 💡 Icon Not Updating?

Windows sometimes caches folder icons aggressively. If your new icon doesn’t appear immediately, try one of these:

- Press `F5` to refresh the folder.

- Close and reopen File Explorer.

- Reboot your system

Still not working and can't wait for a reboot?

> [!WARNING]
> 
> **Run the included** `reset_explorer_icon_cache.ps1`  
> *(Right-click → Run with PowerShell)*

This will:

- Close all File Explorer windows

- Delete Windows’ icon cache

- Restart Explorer automatically

**⚠ Make sure to save any open work** — this will temporarily shut down Explorer.

</details>

---

## ❤️ Support

If you find this useful, feel free to [buy me a coffee](https://ko-fi.com/H2H818FHX)!
