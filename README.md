# Jagex Launcher Linux

This repo contains instruction on how to install the Jagex Launcher in Linux<br>
This also sets up the Flatpak RuneScape client and installs RuneLite<br>

## Disclaimer

I am not responsible for the maintenance and safety of content produced and hosted by third parties and any use of third-party sites is at your own risk

# Table of contents

- [Jagex Launcher](#jagex-launcher)
- [RuneScape](#runescape)
- [Old School RuneScape](#old-school-runescape)
- [Steam Deck](#steam-deck)
- [Troubleshooting](#troubleshooting)
- [References](#references)

# Jagex Launcher

## Requirements

### Lutris
To install and run the jagex launcher you need Lutris:<br>
https://lutris.net/downloads
> **Note**<br>
> To avoid dependency issues we recommend using the Flatpak version

If you are not using the Flatpak version we recommend installing the latest version of wine staging as well as wine dependencies:
https://wiki.winehq.org/Download<br>
https://github.com/lutris/docs/blob/master/WineDependencies.md<br>

### Flatpak and Flatseal
If you are using the flatpak version of Lutris or the Flatpak RuneScape client you need Flatpak and Flatseal:<br>
https://www.flatpak.org/setup<br>
https://flathub.org/apps/com.github.tchx84.Flatseal<br>

## Installation

Download the latest version of the Jagex Launcher install script:<br>
https://github.com/TormStorm/jagex-launcher-linux/blob/main/resources/jagexlauncher.yml<br>
Open Lutris and click the + in the top left corner<br>
Select `Install from a local install script` and choose the script you downloaded<br>
Make sure to leave the default installation path

After clicking install the installer will appear to freeze. This is expected, and the installer still works in the background<br>
After waiting about one minute you can close the Jagex Launcher with the following command:<br>
```ps aux | grep 'cache/lutris/installer/jagex-launcher/jagexlauncher/' | grep -v grep | awk '{print $2}' | xargs kill```

If you are using the flatpak version of Lutris launch Flatseal. Select Lutris and under Filesystem enable all user files<br>

# RuneScape

The Flatpak RuneScape client can be launched from the Jagex Launcher after installing it from Flathub:<br>
```flatpak install flathub com.jagex.RuneScape```<br>

# Old School RuneScape

The official Old School RuneScape client can be installed in the Jagex Launcher<br>
The RuneLite client is automatically installed and can be played by selecting it from the dropdown menu

# Steam Deck

Switch to desktop mode by pressing Steam -> Power -> Switch to Desktop<br>
Follow the instructions for installing the Jagex Launhcer as normal<br>

> **Note**<br>
> It is recommended to install AnyDesk on the Steam Deck as well as on your PC to do the installation remotely as it makes installation steps that involve the terminal much more manageable<br>

Once the installation is complete do the below steps:<br>

Install BoilR from the discover store<br>
Choose Import Games on the left, then make sure "Jagex Launcher" is checked in the list underneath Lutris<br>
Click the button on the bottom left that is a picture of a controller pointing at steam<br>
It should say "Done Importing Games"<br>
Restart steam<br>
Find the new entry for "Jagex Launcher"<br>
Rename to RuneScape if playing RS3<br>
Rename to OSRS or RuneLite if playing OSRS<br>
This is because steam deck searches for control layouts based on game name<br>
Reboot to game mode and launch the new entry<br>
Press the steam button -> Controller Settings -> Browse community layouts<br>
Choose a layout that looks good for you and then you should be good to start playing<br>

If you are using RuneLite, there are many resolution and wonky ui issues with Steam Deck out of the box. The installer creates a properties file you can import to solve most of these issues. [^1] You can import this by clicking the wrench in the top right of RuneLite, clicking the "profiles" tab, then clicking "import profile" and select the file called steamdeck-config.properties in the installation directory (usually /home/<user>/Games/jagex-launcher). The file selector can be very wonky in game mode, so recommend doing this in Desktop mode right after installation

# Troubleshooting

Timeout waiting for window to load<br>
Try to run the installer again as it might have timed out downloding the necessary dependencies<br>

Exit with return code 256 during installation<br>
Delete the folder inside /data/lutris/runners/wine and restart the installation<br>

The Jagex Launcher opens, but the screen is black<br>
Simply resize the window<br>

Lutris can't open the file selector<br>
Run the following command: `systemctl restart --user xdg-desktop-portal`<br>

The audio is crackling<br>
This is a known problem. See [issue 12](https://github.com/TormStorm/jagex-launcher-linux/issues/12) for possible solutions<br>
  
# References
[^1]: [PSA: Perfect RuneLite settings for Steam Deck](https://www.reddit.com/r/2007scape/comments/yzbuwc/psa_perfect_runelite_settings_for_steam_deck)

