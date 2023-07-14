# Jagex Launcher Linux

This repo contains instruction on how to install the Jagex Launcher in Linux, it also sets up the Flatpak RuneScape client and RuneLite<br>

## Disclaimer

I am not responsible for the maintenance and safety of content produced and hosted by third parties and any use of third-party sites is at your own risk

## Contents

- [Jagex Launcher](#jagex-launcher)
- [Game clients](#game-clients)
- [Troubleshooting](#troubleshooting)
- [References](#references)

# Jagex Launcher

## Requirements

* [Flatpak](https://www.flatpak.org/setup)<br>
* [Lutris](https://flathub.org/apps/net.lutris.Lutris)<br>
* [Installation script](https://github.com/TormStorm/jagex-launcher-linux/blob/main/resources/jagexlauncher.yml)<br>

## Installation

> **Note**<br>
> After clicking install the window will appear to freeze, this is expected and it should finish within a couple of minutes<br>

1. Get the requirements from the links above and open Lutris<br>
2. In the bottom left under `Runners` click on `Wine` and choose `Manage Versions`<br>
3. Install the latest `lutris-GE-Proton` version. E.g. `lutris-GE-Proton8-10`<br>
4. Click the `+` in the top left corner of Lutris and select `Install from a local install script`<br>
5. Follow the on screen instructions leaving the installation directory as default 

## Steam Deck

> **Note**<br>
> It is recommended to install a remote desktop application to make the installation easier<br>

Switch to desktop mode by pressing steam, power, switch to desktop and then follow the instructions above<br>
Once the installation has completed do the following steps:<br>

1 .Install BoilR from the discover store<br>
2. Select `Import Games` and make sure the Jagex Launcher is checked under Lutris<br>
3. Click the import games button on the bottom left and restart steam<br>
4. Rename the Steam entry to `RuneScape` if playing RuneScape or `OSRS` if playing Old School RuneScape<br>
5. Press the steam button, controller settings, browse community layouts and select a controller layout<br>

If you are using RuneLite on the Steam Deck you can import a properties file to set it up automatically[^1]<br>

1. Launch RuneLite, open the configuration menu and select the profiles tab<br>
2. Click `import profile` navigate to `$HOME/Games/jagex-launcher` and open `steamdeck-config.properties`
3. Double-click the imported profile to select it

# Game Clients

The supported game clients are the Flatpak RuneScape client, the Java Old School RuneScape client and RuneLite<br>

## RuneScape

The Flatpak RuneScape client can be launched after installing it from FlatHub[^2]<br>

## Old School RuneScape

The Java Old School RuneScape client can be installed in the Jagex Launcher<br>
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
You can try to get it working by installing wine-staging[^3] and wine dependencies[^4] but your your success may vary
  
# References
[^1]: [PSA: Perfect RuneLite settings for Steam Deck](https://www.reddit.com/r/2007scape/comments/yzbuwc/psa_perfect_runelite_settings_for_steam_deck)
[^2]: [Flatpak RuneScape client](https://flathub.org/apps/com.jagex.RuneScape)
[^3]: [wine-staging](https://wiki.winehq.org/Download)
[^4]: [wine dependencies](https://github.com/lutris/docs/blob/master/WineDependencies.md)

