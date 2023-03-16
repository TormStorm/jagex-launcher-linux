# Jagex launcher for Linux

> **Warning**<br>
> This branch may not contain working or complete instructions. Please use the main branch

This repo contains instruction on how to run the Jagex Launcher in Linux as well as how to play through RuneLite

### Disclaimer

I am not affiliated with Jagex or RuneLite, and assumes no responsibility for the contens of this page

> **Note**<br>
> Replace USERNAME with the name of your Linux user

## Table of Contents
**[Run the Jagex Launcher with Bottles](#run-the-jagex-launcher-with-bottles)**<br>
**[Run the Jagex Launcher on Steam Deck](#run-the-jagex-launcher-on-steam-deck)**<br>
**[Run the Jagex Launcher manually](#run-the-jagex-launcher-manually)**<br>
**[RuneLite with Bottles or Manual](#runelite-with-bottles-or-manual)**<br>
**[RuneLite on Steam Deck](#runelite-on-steam-deck)**<br>
**[Credits](#credits)**

## Run the Jagex Launcher with Bottles

### Requirements

[Bottles](https://flathub.org/apps/details/com.usebottles.bottles)<br>
[Jagex Launcher for Windows](https://www.jagex.com/en-GB/launcher)<br>
Windows Virtual Machine or Windows computer<br>
  
### Jagex Launcher
Install the Jagex Launcher either in a Windows virtual machine or on a seperate computer<br>
Copy the installation folder to the following directory:<br> `/home/USERNAME/.var/app/com.usebottles.bottles/data/bottles/bottles/Jagex-Launcher/drive_c/Program Files (x86)`<br>

### Bottles
Install Bottles with the link above<br>
Create a new bottle and name it Jagex Launcher. Under enviorment select `Application`<br>
Select `Run Excecutable` and select the Jagex Launcher executable<br>
Close Bottles and run the following commmand: `flatpak override com.usebottles.bottles --user --filesystem=xdg-data/applications`<br>
Open Bottles again and select the Jagex Launcher. Click the three dots to the right of the bottle and select `Add Desktop Entry`
 
 
## Run the Jagex Launcher on Steam Deck
<br>  
  
## Run the Jagex Launcher manually

### Requirements

- [Wine](https://www.gloriouseggroll.tv/how-to-get-out-of-wine-dependency-hell)
- [WineTricks](https://github.com/Winetricks/winetricks)
- [Jagex Launcher for Windows](https://www.jagex.com/en-GB/launcher)
- [Jagex Launcher icon](https://runescape.wiki/images/Jagex_Launcher_icon.png)
- .NET Framework 4.8
- Windows Virtual Machine or Windows computer

### Wine

Install Wine with the link above and follow the instructions for your distribution<br>

### WineTricks
Install WineTricks through your package manager. For example: `sudo apt install winetricks`

### .NET Framework

Install .NET Framework with the following command: `winetricks --force -q dotnet48`

### Jagex Launcher
Install the Jagex Launcher either in a Windows virtual machine or on a seperate computer<br>
Copy the installation folder to your home directory on your Linux computer<br>

### Desktop entry
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

<!--
## Run the Jagex Launcher with Lutris

### Requirements

- [Lutris](https://lutris.net/downloads)
- [Wine Binary](https://github.com/DavidoTek/ProtonUp-Qt/releases)
- [Jagex Launcher for Windows](https://www.jagex.com/en-GB/launcher)
- [RuneLite Appimage](https://runelite.net)
- Windows Virtual Machine or Windows computer
- .NET Framework 4.8

### Instructions

### Create custom wine prefix
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
 
-->

## RuneLite with Bottles or manual

### Requirements
[RuneLite for Linux](https://runelite.net)<br>

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

### Windows Registry

Create a new file called `InstallLocation.reg` with the following text:
```
Windows Registry Editor Version 5.00
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\RuneLite Launcher_is1]
"InstallLocation"="/home/USERNAME/.wine/drive_c/users/USERNAME/AppData/Local/RuneLite"
```
Save the file in your home directory<br>
Open Windows Registry Editor with the following command: `winetricks regedit`<br>
Select registry, Import Registry File.. and import the file you just created.

## RuneLite on Steam Deck
<br>

# Credits

Thanks to these amazing people for making the information available to create this repo

How to Run Jagex Launcher on Steam Deck/Linux Utilizing Bottles [by jeremiah1119](https://www.reddit.com/r/2007scape/comments/11q8mly/how_to_run_jagex_launcher_on_steam_decklinux/)<br>
How to use Jagex's New Launcher on Linux [by c00k](https://www.youtube.com/watch?v=izLxF_Wwinw)<br>
Native Linux RuneLite running with Jagex [Launcher by jolty__](https://www.reddit.com/r/2007scape/comments/uo1ey1/native_linux_runelite_running_with_jagex_launcher)
