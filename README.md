![](https://runescape.wiki/images/thumb/Jagex_Launcher_icon.png/128px-Jagex_Launcher_icon.png)
# Jagex Launcher Linux

This repository contains instruction on how to install the Jagex Launcher in Linux to play RuneScape and Old School RuneScape

## Jagex Launcher

### Requirements

* [Flatpak](https://www.flatpak.org/setup)<br>
* [Lutris](https://flathub.org/apps/net.lutris.Lutris)<br>
* [Installation script](https://github.com/TormStorm/jagex-launcher-linux/tree/testing/resources)<br>

### Installation

There are two versions of the installation script, flatpak and non-flatpak<br>
We recommend using the flatpak unless you are on a Steam Deck or are having issues with flatpak<br>

1. Get the requirements from the links above and open Lutris<br>
2. Click the `+` in the top left corner of Lutris, select `Install from a local install script` and navigate to `jagexlauncher.yml`<br>
3. Follow the on screen instructions leaving the installation directory as default<br>

### Game Clients

#### Flatpak

If you are using the flatpak installation script you can install the following clients:

RuneScape: `flatpak install flathub com.jagex.RuneScape`<br>
RuneLite: `flatpak install flathub net.runelite.RuneLite`<br>
HDOS: `flatpak install flathub dev.hdos.HDOS`<br>

#### Non-Flatpak

If you are using the non-flatpak installation script all of the third-party clients are pre-installed<br>
To play the official clients simply download them from the Jagex Launcher<br>

### Steam Deck

> [!IMPORTANT]<br>
> You need to use the non-flatpak installation script on the Steam Deck<br>

Switch to desktop mode by pressing steam, power, switch to desktop and then follow the instructions above<br>
Once the installation has completed do the following steps:<br>

1. Install BoilR from the discover store<br>
2. Select `Import Games` and make sure the Jagex Launcher is checked under Lutris<br>
3. Click the import games button on the bottom left and restart steam<br>
4. Rename the Steam entry to `RuneScape` if playing RuneScape or `OSRS` if playing Old School RuneScape<br>
5. Press the steam button, controller settings, browse community layouts and select a controller layout<br>

If you are using RuneLite on the Steam Deck you can import a properties file to set it up automatically<br>

1. Download the [steamdeck-config file](https://github.com/TormStorm/jagex-launcher-linux/blob/testing/resources/steamdeck-config.properties)
2. Launch RuneLite, open the configuration menu and select the profiles tab<br>
3. Click `import profile` navigate to `$HOME/Games/jagex-launcher` and open `steamdeck-config.properties`
4. Double-click the imported profile to select it

### Additional information

For additional information and troubleshooting visit the [jagex-launcher-linux wiki](https://github.com/TormStorm/jagex-launcher-linux/wiki)<br>
