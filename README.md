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

* [Flatpak](https://www.flatpak.org/setup)<br>
* [Flatseal](https://flathub.org/apps/com.github.tchx84.Flatseal)<br>
* [Lutris](https://flathub.org/apps/net.lutris.Lutris)<br>


## Installation

Download the latest version of the [install script](https://raw.githubusercontent.com/TormStorm/jagex-launcher-linux/main/resources/jagexlauncher.yml)<br>
Open Lutris and click the `+` in the top left corner<br>
Select `Install from a local install script` and navigate to the install script<br>
After clicking install the client will appear to freeze. This is expected and the installer should finnish within a couple of minutes<br>
After the installation has completed launch Flatseal<br>
Select Lutris and under Filesystem enable all user files<br>

# RuneScape

The Flatpak RuneScape client can be launched after installing it from [Flathub](https://flathub.org/apps/com.jagex.RuneScape)<br>

# Old School RuneScape

The official Old School RuneScape client can be installed in the Jagex Launcher<br>
The RuneLite client is automatically installed and can be played by selecting it from the dropdown menu

# Steam Deck

Switch to desktop mode by pressing Steam -> Power -> Switch to Desktop<br>
Follow the instructions for installing the Jagex Launhcer as normal<br>

> **Note**<br>
> It is recommended to install a remote desktop application to make the installation easier<br>

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

## RuneLite
If you are using RuneLite on the Steam Deck there are some issues out of the box. The installer creates a properties file you can import to solve most of these issues[^1]<br>

You can import this file by opening the RuneLite configuration and clicking the profiles tab<br>
Click `import profile` and navigate to `$HOME/Games/jagex-launcher`<br>
Select the steamdeck-config.properties file and click open<br>

# Troubleshooting

**Timeout waiting for window to load**<br>
Try to run the installer again as it might have timed out downloding the necessary dependencies<br>

**Exit with return code 256 during installation**<br>
Delete the folder inside `$HOME.var/app/net.lutris.Lutris/data/lutris/runners/wine` and restart the installation<br>

**The Jagex Launcher opens, but the screen is black**<br>
Simply resize the window<br>

**Lutris can't open the file selector**<br>
Run the following command: `systemctl restart --user xdg-desktop-portal`<br>

**The audio is crackling**<br>
Navigate to the following directory: `$HOME/Games/jagex-launcher/drive_c/Program Files (x86)/Jagex Launcher/Games/RuneScape`
Open `runescape.sh` and change the `PULSE_LATENCY_MSEC`
  
**Not using Flatpak**<br>
It is recommended to use flatpak to avoid dependency issues<br>
You can try to get it working by installing [wine-staging](https://wiki.winehq.org/Download) and [wine dependencies](https://github.com/lutris/docs/blob/master/WineDependencies.md) but your your success will vary
  
# References
[^1]: [PSA: Perfect RuneLite settings for Steam Deck](https://www.reddit.com/r/2007scape/comments/yzbuwc/psa_perfect_runelite_settings_for_steam_deck)

