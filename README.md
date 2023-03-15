# Jagex launcher for Linux

This repo contains instruction on how to run the Jagex Launcher in Linux as well as how to play through RuneLite

> **Warning**<br>
> This branch may not contain working or complete instructions. Please use the main branch

### Disclaimer

I am not affiliated with Jagex or RuneLite, and assumes no responsibility for the contens of this page

> **Note**<br>
> Replace USERNAME with the name of your Linux user

## Run with Bottles
<details>
  <summary>The easiest way to run the Jagex Launcher is with Bottles (Click to expand)</summary>
  
  ## Requirements

- [Bottles](https://flathub.org/apps/details/com.usebottles.bottles)
- [Jagex Launcher for Windows](https://www.jagex.com/en-GB/launcher)
- [RuneLite for Linux](https://runelite.net)
- Windows Virtual Machine or Windows computer
  <br>
  
## Jagex Launcher
Install the Jagex Launcher either in a Windows virtual machine or on a seperate computer<br>
Copy the installation folder to the following directory:<br> `/home/USERNAME/.var/app/com.usebottles.bottles/data/bottles/bottles/Jagex-Launcher/drive_c/Program Files (x86)`<br>

## Bottles
Install Bottles with the link above<br>
Create a new bottle and name it Jagex Launcher. Under enviorment select `Application`<br>
Select `Run Excecutable` and select the Jagex Launcher executable<br>
Close Bottles and run the following commmand: `flatpak override com.usebottles.bottles --user --filesystem=xdg-data/applications`<br>
Open Bottles again and select the Jagex Launcher. Click the three dots to the right of the bottle and select `Add Desktop Entry`

## RuneLite

Navigate to this directory: `/home/USERNAME/.wine/drive_c/users/USERNAME/AppData/Local`<br>
Create a new folder called `RuneLite`and move `RuneLite.AppImage` to this directory.<br>
Make the file executable with the following command: `sudo chmod +x RuneLite.AppImage`<br>

Create a new file called `RuneLite.sh` with the following text:
```
#!/bin/sh
cd /home/USERNAME/.wine/drive_c/users/USERNAME/AppData/Local/RuneLite
./RuneLite.AppImage
```
Save the file in the `RuneLite` folder you just created<br>
Make `RuneLite.sh` executable with the following command: `sudo chmod +x RuneLite.sh`<br>
Create a symbolic link to `RuneLite.sh` with the following command: `ln -s RuneLite.sh RuneLite.exe`

## Windows Registry

Create a new file called `InstallLocation.reg` with the following text:
```
Windows Registry Editor Version 5.00
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\RuneLite Launcher_is1]
"InstallLocation"="/home/USERNAME/.wine/drive_c/users/USERNAME/AppData/Local/RuneLite"
```
Save the file in your home directory<br>
Open Windows Registry Editor with the following command: `winetricks regedit`<br>
Select registry, Import Registry File.. and import the file you just created.

<details>
<summary>When you are done it should look like this (Click to show image)</summary><br>
<img src="/assets/images/regedit.png">
</details>

 </details>
 
 ## Run on Steam Deck
<details>
  <summary>Run the Jagex Launcher on the Steam Deck (Click to expand)</summary>
  
  ## Requirements

- [Bottles](https://flathub.org/apps/details/com.usebottles.bottles)
- [Flatseal](https://flathub.org/apps/details/com.github.tchx84.Flatseal)
- [Jagex Launcher for Windows](https://www.jagex.com/en-GB/launcher)
- [RuneLite for Linux] (https://runelite.net)
- Windows Virtual Machine or Windows computer
  <br>

## Jagex Launcher
Install the Jagex Launcher either in a Windows virtual machine or on a seperate computer<br>
Copy the installation folder to the following directory: `/home/deck`<br>

## FlatSeal and Bottles
Install Bottles with the link above<br>
Install Flatseal with the link above<br>
Launch Flatseal and select Bottles. Under Filesystem enable `All user files`. Exit Flatseal<br>
Launch Bottles and then create a new Bottle, naming it Jagex Launcher. Under environment select `Application`<br>
Select `Add Shortcuts...` and select the Jagex Launcher executable<br>
Click the three dots to the right of the bottle and select `Add to Steam`<br>
`At this point the Jagex Launcher should launch properly both in Bottles, and in Steam under the Non-Steam Game category.`<br>
Before continuing with installing RuneLite, Right click the Jagex Launcher icon in the notification tray at the bottom right and select 'Exit'

## RuneLite

Enable hidden files, then navigate to this directory: `/home/deck/.var/app/com.usebottles.bottles/data/bottles/bottles/Jagex-Launcher/drive_c/users/deck/AppData/Local`<br>
Create a new folder called `RuneLite` and move `RuneLite.AppImage` to this directory.<br>
Make the file executable by right clicking the file, selecting permissions, and checking `Is Executable`<br>

Create a new file called `RuneLite.sh` with the following text:
```
#!/bin/sh
cd /home/deck/.var/app/com.usebottles.bottles/data/bottles/bottles/Jagex-Launcher/drive_c/users/deck/AppData/Local/RuneLite
./RuneLite.AppImage --appimage-extract-and-run
```
Save the file in the `RuneLite` folder you just created<br>
Make `RuneLite.sh` executable as well<br>
Right click the RuneLite folder and select "Open Terminal Here"<br>
Create a symbolic link to `RuneLite.sh` with the following command: `ln -s RuneLite.sh RuneLite.exe`

## Windows Registry

Open Bottles, select Jagex Launcher, then scroll down and select Registry Editor<br>
Navigate to the following directory: `HKEY_CURRENT_USER/Software/Microsoft/Windows/CurrentVersion`<br>
Create a new key called `Uninstall`, and then inside that create another key called `RuneLite Launcher_is1`<br>

Create a new string value called `InstallLocation` with the following text:
`/home/deck/.var/app/com.usebottles.bottles/data/bottles/bottles/Jagex-Launcher/drive_c/users/deck/AppData/Local/RuneLite`<br>
Now launch the Jagex Launcher and now with RuneLite selected it should say `Play`.<br>
If not make sure to fully exit the Jagex Launcher and then confirm the paths are accurate.



 </details>
 
  
## Manual Installation
<details>
  <summary>If all else fails you can try to install it manually (Click to expand)</summary>

## Requirements

- [Wine](https://www.gloriouseggroll.tv/how-to-get-out-of-wine-dependency-hell)
- [WineTricks](https://github.com/Winetricks/winetricks)
- [Jagex Launcher for Windows](https://www.jagex.com/en-GB/launcher)
- [Jagex Launcher icon](https://runescape.wiki/images/Jagex_Launcher_icon.png)
- [RuneLite for Linux](https://runelite.net)
- .NET Framework 4.8
- Windows Virtual Machine or Windows computer
<br>

## Wine

Install Wine with the link above and follow the instructions for your distribution<br>

## WineTricks
Install WineTricks through your package manager. For example: `sudo apt install winetricks`

## .NET Framework

Install .NET Framework with the following command: `winetricks --force -q dotnet48`

## Jagex Launcher
Install the Jagex Launcher either in a Windows virtual machine or on a seperate computer<br>
Copy the installation folder to your home directory on your Linux computer<br>

## Desktop entry
Create a new file called `jagex-launcher.desktop` with the following text:
```
[Desktop Entry]
Type=Application
Name=Jagex Launcher
Terminal=false
Exec=wine /home/USERNAME/Jagex\ Launcher/JagexLauncher.exe
Icon=Jagex_Launcher_icon
```

Save the file in: `/home/USERNAME/.local/share/appliations`<br>
Download the Jagex Launcher icon and save it in `/home/USERNAME/.local/share/icons`<br>
Make sure that the exec path is the same as the path to the Jagex Launcher<br>

## RuneLite

Navigate to this directory: `/home/USERNAME/.wine/drive_c/users/USERNAME/AppData/Local`<br>
Create a new folder called `RuneLite`and move `RuneLite.AppImage` to this directory.<br>
Make the file executable with the following command: `sudo chmod +x RuneLite.AppImage`<br>

Create a new file called `RuneLite.sh` with the following text:
```
#!/bin/sh
cd /home/USERNAME/.wine/drive_c/users/USERNAME/AppData/Local/RuneLite
./RuneLite.AppImage
```
Save the file in the `RuneLite` folder you just created<br>
Make `RuneLite.sh` executable with the following command: `sudo chmod +x RuneLite.sh`<br>
Create a symbolic link to `RuneLite.sh` with the following command: `ln -s RuneLite.sh RuneLite.exe`

## Windows Registry

Create a new file called `InstallLocation.reg` with the following text:
```
Windows Registry Editor Version 5.00
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\RuneLite Launcher_is1]
"InstallLocation"="/home/USERNAME/.wine/drive_c/users/USERNAME/AppData/Local/RuneLite"
```
Save the file in your home directory<br>
Open Windows Registry Editor with the following command: `winetricks regedit`<br>
Select registry, Import Registry File.. and import the file you just created.

<details>
<summary>When you are done it should look like this (Click to show image)</summary><br>
<img src="/assets/images/regedit.png">
</details>

</details>

<!--
## Run with Lutris
<details>
  <summary>Run with Lutris (Click to expand)</summary>

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
`WINEPREFIX=~/.local/share/wineprefixes/JagexLauncher winecfg`

### Installing .NET Framework
To install .NET Framework into a new wine prefix open a terminal and type following command<br>
`WINEPREFIX=~/.local/share/wineprefixes/JagexLauncher winetricks --force -q dotnet48`

### Wine binary

Open ProtonUp-QT and check that it installs for Lutris. Click add version, and under compatability tool select "Kron4ek Wine-Builds Vanilla"<br>
Select the newest version and clicking install.


### Lutris

Open lutris and click the pluss sign on the top left and select "Add locally installed game"<br>
In Game Info type "Jagex Launcher" in the name field and under Runner select Wine.<br>
In Game Options under excecutable click browse and select the Jagex Launcher executable and in Wine prefix type `~/.JagexLauncher`<br>
In Runner Options under wine verion select the wine version you installed. Disable DXVM, Esync and FSync and click save.<br>

### Jagex Launcher
Insall the  Jagex Launcher either in a Windows virtual machine or on seperate computer. <br>
Copy the installation folder to your home directory on your Linux computer.

### Desktop entry
Download the Jagex Launcher icon from the [RuneScape Wiki](https://runescape.wiki/w/Jagex_Launcher#/media/File:Jagex_Launcher_icon.png)<br>
To create a desktop entry right click the Jagex Launcher in Lutris and select configure. Under game options click set custom icon and select the image you downloaded.
Right click the Jagex Launcher inside Lutris again and select "Create application menu shortcut"

### RuneLite

Navigate to your wine prefix, create a new folder called RuneLite and copy over the appimage.<br>
`.local/share/wineprefixes/JagexLauncher/drive_c/users/USER/AppData/Local`<br>

To make it executable open a terminal in this directory and type<br>
`sudo chmod +x RuneLite.AppImage`<br>

Create a new file called RuneLite.sh
```
#!/bin/sh
cd ~/.local/share/wineprefixes/JagexLauncher/drive_c/users/USER/AppData/Local/RuneLite
./RuneLite.AppImage
```

After creating the file make it executable by typing<br>
`sudo chmod +x RuneLite.sh`<br>
Next create a symbolic link by typing<br>
`ln -s RuneLite.sh RuneLite.exe`<br>


Finally you need to add a registry key to Wine so the Jagex Launcher thinks RuneLite is installed.<br>

Create a new file called `InstallLocation.reg` with the following text
```
Windows Registry Editor Version 5.00
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\RuneLite Launcher_is1]
"InstallLocation"="/home/USER/.wine/drive_c/users/USER/AppData/Local/RuneLite"
```

Open a terminal and type with following command `WINEPREFIX=~/.local/share/wineprefixes/JagexLauncher winetricks regedit`
Select registry, "Import Registry File.." and import the file you just created.

<details>
  <summary>Once you are done it should look like this</summary>
<img src="/assets/images/regedit.png">
</details>

You are finally finnished, and should be able to open the Jagex launcher with your new desktop entry and if everything is done correctly it should say Play when selecting RuneLite from the client drop down menu.

 </details>
-->

# Credits

Big thanks to these people for making the information available to create this repo.

"How to use Jagex's New Launcher on Linux" by c00k on Youtube
<br>
"Native Linux RuneLite running with Jagex Launcher" by jolty__ on Reddit

