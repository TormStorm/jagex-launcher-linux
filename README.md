# Jagex launcher for Linux

> **Warning**<br>
> This branch may not contain working or complete instructions. Please use the main branch

This repo contains instruction on how to run the Jagex Launcher in Linux as well as how to play through RuneLite

### Disclaimer

I am not affiliated with Jagex or RuneLite, and is not responsible for for the contens of this page.

## Run with Bottles
<details closed>
<summary>The easiest way to run the Jagex Launcher is with Bottles (click to expand)</summary>

### Requirements

- [Bottles](https://flathub.org/apps/details/com.usebottles.bottles)<br>
- [Jagex Launcher for Windows](https://www.jagex.com/en-GB/launcher)<br>
- [RuneLite for Linux](https://runelite.net)<br>
- Windows Virtual Machine or Windows computer<br>

> **Note**<br>
> Replace USERNAME with the name of your Linux user
  
### Jagex Launcher
Install the Jagex Launcher either in a Windows virtual machine or on a seperate computer<br>
Copy the installation folder to the following directory:<br> `/home/USERNAME/.var/app/com.usebottles.bottles/data/bottles/bottles/Jagex-Launcher/drive_c/Program Files (x86)`<br>

### Bottles
Install Bottles with the link above<br>
Create a new bottle and name it Jagex Launcher. Under enviorment select `Application`<br>
Select `Run Excecutable` and select the Jagex Launcher executable<br>
Close Bottles and run the following commmand: `flatpak override com.usebottles.bottles --user --filesystem=xdg-data/applications`<br>
Open Bottles and select the Jagex Launcher. Click the three dots to the right of the bottle and select `Add Desktop Entry`

### RuneLite

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

</details>
<br>

## Run on Steam Deck
 
<details closed>
<summary>Run the Jagex Launcher on the Steam Deck (click to expand)</summary> 
 
### Requirements

- [Bottles](https://flathub.org/apps/details/com.usebottles.bottles)
- [Flatseal](https://flathub.org/apps/details/com.github.tchx84.Flatseal)
- [Jagex Launcher for Windows](https://www.jagex.com/en-GB/launcher)
- [RuneLite for Linux](https://runelite.net)
- Windows Virtual Machine or Windows computer
  <br>

### Jagex Launcher
Install the Jagex Launcher either in a Windows virtual machine or on a seperate computer<br>
Copy the installation folder to the following directory: `/home/deck`<br>

### FlatSeal and Bottles
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

### Windows Registry

Create a new file called `InstallLocation.reg` with the following text:
```
Windows Registry Editor Version 5.00
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\RuneLite Launcher_is1]
"InstallLocation"="/home/deck/.var/app/com.usebottles.bottles/data/bottles/bottles/Jagex-Launcher/drive_c/users/deck/AppData/Local/RuneLite"
```
Save the file in any location, such as `/home/deck/Documents`<br>
Open Bottles, select Jagex Launcher, then scroll down and select Registry Editor<br>
Select registry, Import Registry File.. and import the file you just created.
Now launch the Jagex Launcher and select RuneLite. 'Install' should be replaced with 'Play' and launch RuneLite


</details>
<br>

## Run Manually

<details close>
<summary>Run the Jagex Launcher manually (click to expand)</summary>

### Requirements

- [Wine](https://www.gloriouseggroll.tv/how-to-get-out-of-wine-dependency-hell)
- [WineTricks](https://github.com/Winetricks/winetricks)
- [Jagex Launcher for Windows](https://www.jagex.com/en-GB/launcher)
- [Jagex Launcher icon](https://runescape.wiki/images/Jagex_Launcher_icon.png)
- [RuneLite for Linux](https://runelite.net)
- .NET Framework 4.8
- Windows Virtual Machine or Windows computer

> **Note**<br>
> Replace USERNAME with the name of your Linux user

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

### RuneLite

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

</details>

# Credits

Thanks to these amazing people for making the information available to create this repo

How to Run Jagex Launcher on Steam Deck/Linux Utilizing Bottles [by jeremiah1119](https://www.reddit.com/r/2007scape/comments/11q8mly/how_to_run_jagex_launcher_on_steam_decklinux/)<br>
How to use Jagex's New Launcher on Linux [by c00k](https://www.youtube.com/watch?v=izLxF_Wwinw)<br>
Native Linux RuneLite running with Jagex [Launcher by jolty__](https://www.reddit.com/r/2007scape/comments/uo1ey1/native_linux_runelite_running_with_jagex_launcher)
