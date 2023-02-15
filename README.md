# Jagex launcher for Linux

**THIS BRANCH MAY _NOT_ CONTAIN WORKING OR COMPLETE INCTRUCTIONS. PLEASE USE THE MAIN BRANCH**

This repo contains instruction on how to install the Jagex Launcher on linux through Wine as well as how to play through RuneLite.

### Why i created this repo

The Jagex launcher does not work natively on Linux, and it's not as straight forward to play through RuneLite. Since Jagex havne't provided any documentation on how to run the Jagex Launcher on Linux i created this repo. Hopefully this won't be needed in the future, but until then this repo will provide the nessesary information.

### Disclaimer
**I am not affiliated with Jagex or RuneLite, and i assumes no responsibility for the contens of this page. <br>
Please make sure your download everything from the correct sources.**

## Requirements

- [Lutris](https://lutris.net/downloads)
- [Wine Binary](https://github.com/DavidoTek/ProtonUp-Qt/releases)
- [Jagex Launcher for Windows](https://www.jagex.com/en-GB/launcher)
- [RuneLite Appimage](https://runelite.net)
- Windows Virtual Machine or Windows computer
- .NET Framework 4.8



## Instructions

## Create custom wine prefix
Open a terminal and type the following command<br>
`WINEPREFIX=~/.JagexLauncher winecfg`

### Installing .NET Framework
To install .NET Framework into a new wine prefix open a terminal and type following command<br>
`WINEPREFIX=~/.JagexLauncher winetricks --force -q dotnet48`

### Wine binary

Open ProtonUp-QT and check that it installs for Lutris. Click add version, and under compatability tool select "Kron4ek Wine-Builds Vanilla"<br>
Make sure the version says 8.0 before clicking install.


### Lutris

Open lutris and click the pluss sign on the top left and select "Add locally installed game"<br>
In Game Info type "Jagex Launcher" in the name field and under Runner select Wine.<br>
In Game Options under excecutable click browse and select the Jagex Launcher executable and in Wine prefix type `~/.JagexLauncher`<br>
In Runner Options under wine verion select Wine-8.0. Disable DXVM, Esync and FSync and click save.<br>

### Jagex Launcher
Insall the  Jagex Launcher either in a Windows virtual machine or on seperate computer. <br>
Copy the installation folder to your home directory on your Linux computer.

### Desktop entry
Download the Jagex Launcher icon from the [RuneScape Wiki](https://runescape.wiki/w/Jagex_Launcher#/media/File:Jagex_Launcher_icon.png)<br>
To create a desktop entry right click the Jagex Launcher in Lutris and select configure. Under game options click set custom icon and select the image you downloaded.
Right click the Jagex Launcher inside Lutris again and select "Create application menu shortcut"

### RuneLite

Navigate to your wine prefix, create a new folder called RuneLite and copy over the appimage.<br>
`.JagexLauncher/drive_c/users/USER/AppData/Local`<br>

To make it executable open a terminal in this directory and type<br>
`sudo chmod +x RuneLite.AppImage`<br>

Create a new file called RuneLite.sh
```
#!/bin/sh
cd ~/.JagexLauncher/drive_c/users/USER/AppData/Local/RuneLite
./RuneLite.AppImage
```
<br>
After creating the file make it executable by typing `sudo chmod +x RuneLite.sh`<br>
Next create a symbolic link by typing `ln -s RuneLite.sh RuneLite.exe`


Finally you need to add a registry key to Wine so the Jagex Launcher thinks RuneLite is installed.<br>

Create a new file called `InstallLocation.reg` with the following text
```
Windows Registry Editor Version 5.00
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\RuneLite Launcher_is1]
"InstallLocation"="/home/USER/.wine/drive_c/users/USER/AppData/Local/RuneLite"
```

Open a terminal and type with following command `WINEPREFIX=~/.JagexLauncher winetricks regedit`
Select registry, "Import Registry File.." and import the file you just created.

<details>
  <summary>Once you are done it should look like this</summary>
<img src="/assets/images/regedit.png">
</details>

You are finally finnished, and should be able to open the Jagex launcher with your new desktop entry and if everything is done correctly it should say Play when selecting RuneLite from the client drop down menu.

# Credits

Big thanks to these people for making the information available to create this repo.

"How to use Jagex's New Launcher on Linux" by c00k on Youtube
<br>
"Native Linux RuneLite running with Jagex Launcher" by jolty__ on Reddit

