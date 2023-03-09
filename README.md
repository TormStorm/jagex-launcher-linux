# Jagex launcher for Linux

This repo contains step by step instruction on how to install the Jagex Launcher on linux through Wine as well as how to play through RuneLite.

## Requirements

- [Wine](https://www.gloriouseggroll.tv/how-to-get-out-of-wine-dependency-hell)
- [WineTricks](https://github.com/Winetricks/winetricks)
- [Jagex Launcher for Windows](https://www.jagex.com/en-GB/launcher)
- [RuneLite Appimage (optional)](https://runelite.net)
- .NET Framework 4.8
- Windows Virtual Machine or Windows computer

## Installing Wine

To install Wine with all the necessary dependencies head over to GloriousEggroll website and follow the instructions for your distribution.<br>

## Installing WineTricks
To install WineTricks open a terminal and install it through your packet manager.<br>
E.g. `sudo apt install winetricks`

## Installing .NET Framework

To install .NET Framework open a terminal and type following command<br>
`winetricks --force -q dotnet48`


<details>
<summary>Manual installation (Click to expand)</summary><br>

Open a terminal and start Winetricks with following command `winetricks --force`<br>
Ignore any errors in this step and keep pressing OK until you can proceed.

Select "Select the default wineprefix and click OK"<br>
<img src="/assets/images/wineprefix.png"><br>

Select "Install a Windows DLL or component and click OK"<br>
<img src="/assets/images/component.png"><br>

Select "dotnet48" and click OK
<img src="/assets/images/dotnet48.png"><br>

Accept the license terms and click Install<br>
<img src="/assets/images/dotnet4setup.png">

If you get this warning just click Continue<br>
<img src="/assets/images/dotnetwarning.png"><br>

Accept the license terms and click Install<br>
<img src="/assets/images/dotnet4.8setup.png">

</details>

## Jagex Launcher
Install the Jagex Launcher either in a Windows virtual machine or on seperate computer.<br>
Copy the installation folder to your home directory on your Linux computer.<br>
Open a terminal, navigate to the Jagex Launcher folder and run the following command `wine JagexLauncher.exe`

## Desktop entry
To create a desktop entry open a text editor and create a new text file. Inside the file type the following.
```
[Desktop Entry]
Type=Application
Name=Jagex Launcher
Terminal=false
Exec=wine /home/USER/JagexLauncher/JagexLauncher.exe
Icon=/home/USER/JagexLauncher/icon.png
```

Save the file as "jagex-launcher.desktop" in `/home/USER/.local/share/appliations` where "USER" is the name of your Linux user.<br>
Download an icon and place it and place it in the same folder as Jagex Launcher.<br>
Make sure that the exec path and icon path is the same as the path to the Jagex Launcher.<br>

## RuneLite

Navigate into the following directory `/home/USER/.wine/drive_c/users/USER/AppData/Local` and create a new directory called RuneLite.<br>
Copy RuneLite.AppImage to this folder and make sure that it is executable with the following command: `sudo chmod +x RuneLite.AppImage`<br>
Open a text editor and create a new file called RuneLite.sh<br>
Inside the file type the following where USER is the name of your Linux user.
```
#!/bin/sh
cd /home/USER/.wine/drive_c/users/USER/AppData/Local/RuneLite
./RuneLite.AppImage
```
Make the file executable with the following command `sudo chmod +x RuneLite.sh`<br>
Create a symbolic link with the following command `ln -s RuneLite.sh RuneLite.exe`

Start Winetricks with following command `winetricks --force`<br>
Select "Select the default wineprefix"<br>
Select "Run regedit"

<details>
<summary>(Click to expand)</summary><br>
<img src="/assets/images/wineprefix.png"><br>
<img src="/assets/images/runregedit.png"><br>
</details>

Navigate to the following path `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall`<br>
If you don't have the "Uninstall" folder create it by right clicking inside `CurrentVersion` and selecting new key.<br>
Open the Uninstall folder and create a new folder inside called `RuneLite Launcher_is1`<br>
Inside that folder create a new string value named `InstallLocation`<br>
In value type `/home/USER/.wine/drive_c/users/USER/AppData/Local/RuneLite` where "USER" is the name of your user in Linux.

<details>
<summary>Once you are done it should look like this (Click to show image)</summary><br>
<img src="/assets/images/regedit.png">
</details>

Open the Jagex launcher with your new desktop entry. If everything is done correctly it should say play when selecting RuneLite from the client drop down menu.

# Credits

Big thanks to these people for making the information available to create this repo.

How to use Jagex's New Launcher on Linux [by c00k](https://youtu.be/izLxF_Wwinw)
<br>
Native Linux RuneLite running with Jagex Launcher [by jolty__](https://www.reddit.com/r/2007scape/comments/uo1ey1/native_linux_runelite_running_with_jagex_launcher)

