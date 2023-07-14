# Jagex Launcher Linux

This repo contains instruction on how to install the Jagex Launcher in Linux, it also sets up the Flatpak RuneScape client and RuneLite<br>

## Disclaimer

I am not responsible for the maintenance and safety of content produced and hosted by third parties and any use of third-party sites is at your own risk

# Table of contents

- [Jagex Launcher](#jagex-launcher)
- [Steam Deck](#steam-deck)
- [RuneScape](#runescape)
- [Old School RuneScape](#old-school-runescape)
- [Troubleshooting](#troubleshooting)
- [References](#references)

# Jagex Launcher

## Requirements

* [Flatpak](https://www.flatpak.org/setup)<br>
* [Flatseal](https://flathub.org/apps/com.github.tchx84.Flatseal)<br>
* [Lutris](https://flathub.org/apps/net.lutris.Lutris)<br>


## Installation

Install the requirements from the links above<br>
Download the latest version of the [installation script](https://raw.githubusercontent.com/TormStorm/jagex-launcher-linux/main/resources/jagexlauncher.yml)<br>
In the bottom left, click on `Wine` under `Runners` and then choose `Manage Versions`<br>
Install the latest `lutris-GE-Proton` version. E.g. `lutris-GE-Proton8-10`<br>
Click `OK`. Back in Lutris, click the `+` in the top left corner and select `Install from a local install script`<br>
After clicking install the window will appear to freeze, this is expected and should finish within a couple of minutes<br>
Once the installation has completed launch Flatseal, select Lutris and under filesystem enable all user files<br>

## Steam Deck

> **Note**<br>
> It is recommended to install a remote desktop application to make the installation easier<br>

Switch to desktop mode by pressing steam, power, switch to desktop and then follow the instructions above<br>
Once the installation has completed do the following steps:<br>

Install BoilR from the discover store<br>
Select `Import Games` and make sure the Jagex Launcher is checked under Lutris<br>
Click the import games button on the bottom left and restart steam<br>
Rename the Steam entry to `RuneScape` if playing RuneScape or `OSRS` if playing Old School RuneScape<br>
Press the steam button, controller settings, browse community layouts and select a controller layout<br>

If you are using RuneLite on the Steam Deck you can import a properties file to set it up automatically[^1]<br>
Launch RuneLite, open the configuration menu and select the profiles tab<br>
Click `import profile` navigate to `$HOME/Games/jagex-launcher` and select `steamdeck-config.properties`

# RuneScape

The Flatpak RuneScape client can be launched after installing it from [Flathub](https://flathub.org/apps/com.jagex.RuneScape)<br>

# Old School RuneScape

The official Old School RuneScape client can be installed in the Jagex Launcher<br>
The RuneLite client is automatically installed and can be played by selecting it from the dropdown menu

# Troubleshooting

**Timeout waiting for window to load**<br>
Try to run the installer again as it might have timed out downloading the necessary dependencies<br>

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
You can try to get it working by installing [wine-staging](https://wiki.winehq.org/Download) and [wine dependencies](https://github.com/lutris/docs/blob/master/WineDependencies.md) but your your success may vary
  
# References
[^1]: [PSA: Perfect RuneLite settings for Steam Deck](https://www.reddit.com/r/2007scape/comments/yzbuwc/psa_perfect_runelite_settings_for_steam_deck)

