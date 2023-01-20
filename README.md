# Jagex launcher for Linux

This repo contains instruction on how to install the Jagex Launcher on linux with RuneLite through Wine.

**This document does _NOT_ contain any links to the Jagex Launcher or RuneLite for obvious reasons. Please make sure to download the files from correct websites**

## Why i created this repo

RuneScape itself runs nativly in Linux, but unfortunatly the Jagex launcher does not, and has to be run thorugh Wine. RuneLite is not as straight forward to get running either, and since Jagex havne't provided any documentation on how to make it run i thoght i would this guide. Hopefully this won't be needed in the future, but until then this provides a way for linux users to use the Jagex Launcher.

# How To:

## Requirements
- Wine with dependencies
- WineTricks
- Windows VM or seperate computer
- Jagex Launcher for Windows
- RuneLite AppImage (optional)

## Installing Wine

To install Wine with all the necessary dependencies go to GloriousEggroll's Blog on [How to get out of Wine Dependency hell](https://www.gloriouseggroll.tv/how-to-get-out-of-wine-dependency-hell) and follow the instructions for your distribution. Make sure you also install WineTricks as it's needed for the next step.

## Installing .NET Framework
Open a terminal and run Winetricks by running this command `winetricks--force`. 
<br>
This is to make sure that everything gets intalled correctly.
<br>



<details>
  <summary>Choose "Select the default wineprefix"</summary>
<img src="/assets/images/wineprefix.png" width="75%">
</details>

<details>
  <summary>Next select "Install a Windows DLL or component"</summary>
<img src="/assets/images/component.png" width="75%">
</details>

<details>
  <summary>Select "dotnet48". Ignore any errors and keep pressing OK until you get to the .NET Framework 4 Setup </summary>
<img src="/assets/images/dotnet48.png" width="75%">
</details>

<details>
  <summary>Accept the license terms and click install</summary>
<img src="/assets/images/dotnet4setup.png" width="60%">
</details>

<details>
  <summary>You might get a warning, but it can safely be ignored</summary>
<img src="/assets/images/dotnetwarning.png" width="60%">
</details>

<details>
  <summary>Accept the license terms and click install</summary>
<img src="/assets/images/dotnet4.8setup.png" width="60%">
</details>

## Running the launcher
Unfortunatly to run the Jagex Launcher you need the files from an already installed Jagex launcher in Windows. These files can be obtained either by installing the Jagex launcher in a virtual machine, or on a different computer. Once you have obtained the files open a terminal and navigate to the folder where the launcher files are located. Then simply run `wine JagexLauncher.exe` and the jagex launcher should start up as normal.

## Desktop entry for the Jagex Launcher
Unless you want to open a terminal every time you want to run the Jagex Launcher you should create a desktop entry. To create a desktop entry simply create a new text file with the code below and save it as `jagex-launcher.desktop` inside `/home/user/.local/share/appliations` where `user` is the name of your user in Linux. Make sure you also edit the exec path and icon path to the location of the Jagex Launcher.
```
[Desktop Entry]
Type=Application
Name=Jagex Launcher
Terminal=false
Exec=wine /home/torm/JagexLauncher/JagexLauncher.exe
Icon=/home/torm/JagexLauncher/JagexLauncher.webp
```

If you only want to run the default runescape client you can simply download it from the Jagex Launcher and run it, but if you also want to be able to run RuneLite keep reading. 

## RuneLite in the Jagex Launcher

To set up RuneLite start by heading into the wine directory. It's located in `/home/user/.wine/drive_c/users/user/AppData/Local` Create a new directory called RuneLite and copy over the RuneLite.AppImage file. Next create a new file and call it RuneLite.sh. Inside the file type the following
```
#!/bin/sh
cd "${0%/*}"
./RuneLite.AppImage
```
This file simply changes the path to RuneLite directory and executes RuneLite.appImage. After creating the file make sure that it is executable either by opening a terminal and typing `sudo chmod +x RuneLite.sh`, or by right clicking the file and going into properties. Next open a terminal and create a symbolic link by typing the following `ln -s RuneLite.sh RuneLite.exe`. This file simply runs the RuneLite.sh file, which then runs the RuneLite.AppImage.

Finally you need to add a registry key to Wine so the Jagex Launcher thinks RuneLite is installed.
<br>

<details>
  <summary>To do this start WineTricks again and choose "Select the default wineprefix"</summary>
<img src="/assets/images/wineprefix.png" width="75%">
</details>

<details>
  <summary>Next select "Run regedit"</summary>
<img src="/assets/images/runregedit.png" width="75%">
</details>

Once you have Registry Editor running navigate to the following path `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\` If you do not have a folder called `Uninstall` simply create it by right clicking inside `CurrentVersion` and selecting `New` `Key`. Once you are inside `Uninstall` create a new folder called `RuneLite Launcher_is1`. Inside that folder create a new `String value` with the name `InstallLocation`, and the value `/home/user/.wine/drive_c/users/user/AppData/local/RuneLite` where `user` is the name of your user in Linux. 

<details>
  <summary>Once you are done it should look like this</summary>
<img src="/assets/images/regedit.png" width="75%">
</details>

You are finally finnished, and should be able to open the Jagex launcher with your new desktop entry and if everything is done correctly it should say Play when selecting RuneLite from the client drop down menu.

## Credits

Big thanks to these people for making the information needed available to create this guide

Thanks to c00k for his [Youtube video](https://youtu.be/izLxF_Wwinw) on how to install and run the Jagex Launcher in Linux
<br>
Thanks to jolty__ for his [Reddit post](https://www.reddit.com/r/2007scape/comments/uo1ey1/native_linux_runelite_running_with_jagex_launcher) on how to run RuneLite in the Jagex Launcher

