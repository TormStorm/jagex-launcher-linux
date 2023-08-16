![](https://runescape.wiki/images/thumb/Jagex_Launcher_icon.png/150px-Jagex_Launcher_icon.png)
# Jagex Launcher Linux

This repository contains instruction on how to install the Jagex Launcher in Linux to play RuneScape and Old School RuneScape. It also automatically sets up the Flatpak RuneScape client and RuneLite. For more information visit the [jagex-launcher-linux Wiki](https://github.com/TormStorm/jagex-launcher-linux/wiki)<br>

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
3. Follow the on screen instructions leaving the installation directory as default<br>

To play RuneScape simply install it from FlatHub<br>

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

If you are using RuneLite on the Steam Deck you can import a properties file to set it up automatically<br>

1. Launch RuneLite, open the configuration menu and select the profiles tab<br>
2. Click `import profile` navigate to `$HOME/Games/jagex-launcher` and open `steamdeck-config.properties`
3. Double-click the imported profile to select it

