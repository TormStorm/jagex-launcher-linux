# Jagex launcher for Linux

**THIS BRANCH MAY _NOT_ CONTAIN WORKING OR COMPLETE INCTRUCTIONS. PLEASE USE THE MAIN BRANCH**

This repo contains instruction on how to install the Jagex Launcher on linux through Wine as well as how to play through RuneLite.

### Why i created this repo

The Jagex launcher does not work natively on Linux, and it's not as straight forward to play through RuneLite. Since Jagex havne't provided any documentation on how to run the Jagex Launcher on Linux i created this repo. Hopefully this won't be needed in the future, but until then this repo will provide the nessesary information.

### Disclaimer
**I am not affiliated with Jagex or RuneLite, and i assumes no responsibility for the contens of this page. <br>
Please make sure your download everything from the correct sources.**

## Requirements
- Wine binary
- Lutris
- Jagex Launcher (Windows)
- Windows Virtual Machine or Windows computer
- RuneLite AppImage (optional)

## Instructions

### Wine binary

To download the Wine binary head over to Kron4ek's [Github page](https://github.com/Kron4ek/Wine-Builds/releases) and download "wine-8.0-amd64"<br>
Extract the zipped file and place it somewhere in your home directory,

### Lutris

Install Lutris either through an appstore or the terminal. e.g:  `sudo apt install lutris`


<!---### Installing .NET Framework
To install .NET Framework open a terminal and type following command `winetricks --force -q dotnet48`--->

### Jagex Launcher
Download and insall the [Jagex Launcher](https://www.jagex.com/en-GB/launcher) either in a Windows virtual machine or on seperate computer. <br>
Copy the installation folder to your home directory on your Linux computer.


### Lutris

Open lutris and click the pluss sign on the top left. Select "Add locally installed game"<br>
In the Game Info tab type "Jagex Launcher" in the name field and under Runner select Wine.<br>
In the Game Options tab click browse and select the Jagex Launcher executable Under excecutable.<br>
In the Runner Options click the Advanced toggle in the top right and under Wine version select custom.<br>
Under Custom Wine executable select the directory to the Wine binary you downloaded. Example: `/home/USER/wine-8.0/bin/wine`<br>
Disable all of the enabled toggles in the Runner Options.
In the System Options disable all of the enabled toggles and click save.

### Desktop entry
Download the Jagex Launcher icon from the [RuneScape Wiki](https://runescape.wiki/w/Jagex_Launcher#/media/File:Jagex_Launcher_icon.png)<br>
To create a desktop entry right click the Jagex Launcher in Lutris and select configure. Under game options select the custom on the top right and select the image you downloaded and click save.<br>
Right click the Jagex Launcher inside Lutris again and select "Create application menu shortcut"

### RuneLite

Download [RuneLite for Linux](https://runelite.net) and navigate into the following directory on your computer `/home/USER/.wine/drive_c/users/USER/AppData/Local` Create a new directory and call it RuneLite. Copy RuneLite.AppImage to this folder and make sure that it is executable by opening a terminal and typing `sudo chmod +x RuneLite.AppImage` Open a text editor and create a new file called RuneLite.sh Inside the file type the following where USER is the name of your Linux user.
```
#!/bin/sh
cd /home/USER/.wine/drive_c/users/USER/AppData/Local/RuneLite
./RuneLite.AppImage
```
After creating the file make sure that it is also executable by typing `sudo chmod +x RuneLite.sh` Next create a symbolic link by typing `ln -s RuneLite.sh RuneLite.exe`


Finally you need to add a registry key to Wine so the Jagex Launcher thinks RuneLite is installed.<br>

Create a new file called `InstallLocation.reg` with the following text and save it in your home directory.

```
Windows Registry Editor Version 5.00
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\RuneLite Launcher_is1]
"InstallLocation"="/home/USER/.wine/drive_c/users/USER/AppData/Local/RuneLite"
```

Open a terminal and type with following command `winetricks regedit`
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

