# Jagex Launcher Linux

This repository contains instruction on how to install the Jagex Launcher in Linux using Lutris. It also automatically sets up the Flatpak RuneScape client and RuneLite<br>

|                 Content             |
| ---------------------------------   |
| [Jagex Launcher](#jagex-launcher)   |
| [Game clients](#game-clients)       |
| [Troubleshooting](#troubleshooting) |
| [References](#references)           |

## Jagex Launcher

### Requirements

* [Flatpak](https://www.flatpak.org/setup)<br>
* [Lutris](https://flathub.org/apps/net.lutris.Lutris)<br>
* [Installation script](https://github.com/TormStorm/jagex-launcher-linux/blob/main/resources/jagexlauncher.yml)<br>

### Installation

> **Note**<br>
> After clicking install the window will appear to freeze, this is expected and it should finish within a couple of minutes<br>

1. Get the requirements from the links above and open Lutris<br>
2. Click the `+` in the top left corner of Lutris and select `Install from a local install script`<br>
3. Follow the on screen instructions leaving the installation directory as default 

### Steam Deck

> **Note**<br>
> It is recommended to install a remote desktop application to make the installation easier<br>

Switch to desktop mode by pressing steam, power, switch to desktop and then follow the instructions above<br>
Once the installation has completed do the following steps:<br>

1. Install BoilR from the discover store<br>
2. Select `Import Games` and make sure the Jagex Launcher is checked under Lutris<br>
3. Click the import games button on the bottom left and restart steam<br>
4. Rename the Steam entry to `RuneScape` if playing RuneScape or `OSRS` if playing Old School RuneScape<br>
5. Press the steam button, controller settings, browse community layouts and select a controller layout<br>

If you are using RuneLite on the Steam Deck you can import a properties file to set it up automatically<sup title="PSA: Perfect RuneLite settings for Steam Deck">[^1]</sup><br>

1. Launch RuneLite, open the configuration menu and select the profiles tab<br>
2. Click `import profile` navigate to `$HOME/Games/jagex-launcher` and open `steamdeck-config.properties`
3. Double-click the imported profile to select it

## Game Clients

### RuneScape
The Flatpak client can be launched after installing it from FlatHub<sup title="Flatpak RuneScape client">[^2]</sup><br>

### Old School RuneScape
The New Official client can be launched after installing it from the dropdown menu<br>
The RuneLite client is automatically installed and can be launched by selecting it from the dropdown menu

## Troubleshooting

**Timeout waiting for window to load**<br>
Try to run the installer again as it might have timed out downloading the necessary dependencies<br>

**Exit with return code 256 during installation**<br>
Delete the folder inside `$HOME.var/app/net.lutris.Lutris/data/lutris/runners/wine` and restart the installation<br>

**The Jagex Launcher opens, but the screen is black**<br>
Simply resize the window<br>

**Lutris can't open the file selector**<br>
Run the following command: `systemctl restart --user xdg-desktop-portal`<br>

**The audio is crackling**<br>
Navigate to the following directory: `$HOME/Games/jagex-launcher/drive_c/Program Files (x86)/Jagex Launcher/Games/RuneScape`<br>
Open `runescape.sh` and change the `PULSE_LATENCY_MSEC`

**The Jagex Launcher UI is too small**<br>
Open Lutris, right click the Jagex Launcher and select Configure. Open the runner options tab and select `Enable DPI Scaling`

**The RuneLite UI is too small**<br>
Navigate to the following directory: `$HOME/Games/jagex-launcher/drive_c/Program Files (x86)/Jagex Launcher/Games/RuneLite`<br>
Open `runelite.sh` and add `env GDK_SCALE=2` to the start of the command

**Not using Flatpak**<br>
It is recommended to use flatpak to avoid dependency issues<br>
You can try to get it working by installing wine staging<sup title="Wine Staging">[^3]</sup> and wine dependencies<sup title="Wine Dependencies">[^4]</sup> but your your success will vary

## References
[^1]: [PSA: Perfect RuneLite settings for Steam Deck](https://www.reddit.com/r/2007scape/comments/yzbuwc/psa_perfect_runelite_settings_for_steam_deck)
[^2]: [Flatpak RuneScape client](https://flathub.org/apps/com.jagex.RuneScape)
[^3]: [Wine staging](https://wiki.winehq.org/Download)
[^4]: [Wine dependencies](https://github.com/lutris/docs/blob/master/WineDependencies.md)<br>
