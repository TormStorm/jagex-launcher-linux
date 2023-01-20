# Jagex launcher for Linux

This repo contains instruction on how to install the Jagex Launcher on linux through Wine as well as how to play through RuneLite.

## Why i created this repo

Unfortunatly the Jagex launcher does not work natively on Linux, and it's not as straight forward to play through RuneLite. Since Jagex havne't provided any documentation on how to run the Jagex Launcher on Linux i created this repo. Hopefully this won't be needed in the future, but until then this repo will provide the nessesary information.

# Instructions

**This repo does _NOT_ contain any links. Please make sure you download everything from the correct websites**

## Requirements
- Wine with dependencies
- WineTricks
- Windows VM or Windows computer
- Jagex Launcher for Windows
- RuneLite AppImage (optional)

## Installing Wine

To install Wine with all the necessary dependencies head over to GloriousEggroll website and in the Wine (Linux) category you will find a page called "How to get out of Wine Dependency hell" Follow the instructions for your distribution. Make sure you also install WineTricks as it's needed for the next step.

## Installing .NET Framework
Open a terminal and start Winetricks with following command `winetricks --force`

Ignore any errors in this step and keep pressing OK until you can proceed.

<details>
  <summary>Select "Select the default wineprefix and click OK"</summary>
<img src="/assets/images/wineprefix.png" width="75%">
</details>

<details>
  <summary>Select "Install a Windows DLL or component and click OK"</summary>
<img src="/assets/images/component.png" width="75%">
</details>

<details>
  <summary>Select "dotnet48" and click OK</summary>
<img src="/assets/images/dotnet48.png" width="75%">
</details>

<details>
  <summary>Accept the license terms and click Install</summary>
<img src="/assets/images/dotnet4setup.png" width="60%">
</details>

<details>
  <summary>You might get a warning in the Microsoft .NET Framework installer, just click Continue</summary>
<img src="/assets/images/dotnetwarning.png" width="60%">
</details>

<details>
  <summary>Accept the license terms and click Install</summary>
<img src="/assets/images/dotnet4.8setup.png" width="60%">
</details>

## Running the Jagex Launcher
Unfortunatly to run the Jagex Launcher you need all of the files from an already installed Jagex launcher in Windows. These files can be obtained either by installing the Jagex launcher in Windows on a virtual machine, or on a seperate computer. Once you have obtained the files place them in a folder, preferably in your home directory and open a terminal. Navigate to the folder you created and start the Jagex Launcher by running the following command `wine JagexLauncher.exe`

## Desktop entry
Unless you want to open a terminal every time you want to run the Jagex Launcher you should create a desktop entry. To create a desktop entry simply open a text editor and create a new text file. Inside the file type the following.
```
[Desktop Entry]
Type=Application
Name=Jagex Launcher
Terminal=false
Exec=wine /home/USER/JagexLauncher/JagexLauncher.exe
Icon=/home/USER/JagexLauncher/icon.png
```

Save the file as "jagex-launcher.desktop" in `/home/USER/.local/share/appliations` where "USER" is the name of your user in Linux and make sure that the exec path and icon path is the same as the folder you created earlier. Lastly download an icon and place it in the same folder. The Jagex Launcher icon can be found both on the OldSchool Wiki and the Runescape Wiki on the Jagex Launcher page.


If you only want to use the default runescape clients you can simply download it straight from the Jagex Launcher and run it, but if you also want to use RuneLite keep reading. 

## RuneLite

To set up RuneLite navigate into the following directory `/home/USER/.wine/drive_c/users/USER/AppData/Local` Create a new directory and call it RuneLite. Copy RuneLite.AppImage to this folder and make sure that it is executable by opening a terminal and typing `sudo chmod +x RuneLite.AppImage` Open a text editor and create a new file called RuneLite.sh Inside the file type the following
```
#!/bin/sh
cd "${0%/*}"
./RuneLite.AppImage
```
After creating the file make sure that it is also executable by typing `sudo chmod +x RuneLite.sh` Next create a symbolic link by typing `ln -s RuneLite.sh RuneLite.exe`


Finally you need to add a registry key to Wine so the Jagex Launcher thinks RuneLite is installed.
Open a terminal and start Winetricks with following command `winetricks`
<details>
  <summary>Select "Select the default wineprefix"</summary>
<img src="/assets/images/wineprefix.png" width="75%">
</details>

<details>
  <summary>Select "Run regedit"</summary>
<img src="/assets/images/runregedit.png" width="75%">
</details>

Navigate to the following path `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall` If you don't have the "Uninstall" folder simply create it by right clicking inside `CurrentVersion` and selecting new key. Once you are inside `Uninstall` create a new folder called `RuneLite Launcher_is1` Inside that folder create a new string value named `InstallLocation` with the value `/home/USER/.wine/drive_c/users/USER/AppData/Local/RuneLite` where "USER" is the name of your user in Linux.

<details>
  <summary>Once you are done it should look like this</summary>
<img src="/assets/images/regedit.png" width="75%">
</details>

You are finally finnished, and should be able to open the Jagex launcher with your new desktop entry and if everything is done correctly it should say Play when selecting RuneLite from the client drop down menu.

# Credits

Big thanks to these people for making the information available to create this repo.

"How to use Jagex's New Launcher on Linux" by c00k on Youtube
<br>
"Native Linux RuneLite running with Jagex Launcher" by jolty__ on Reddit

