 ## Run the Jagex Launcher on Steam Deck
 
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