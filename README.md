![](https://runescape.wiki/images/thumb/Jagex_Launcher_icon.png/128px-Jagex_Launcher_icon.png)
# Jagex Launcher Linux

This repository contains instruction on how to install the Jagex Launcher in Linux to play RuneScape and Old School RuneScape

## Disclaimer

I am not responsible for the maintenance and safety of content produced and hosted by third parties and any use of third-party sites is at your own risk

## Jagex Launcher

### Requirements

* [Flatpak](https://www.flatpak.org/setup)<br>
* [Lutris v0.5.14](https://flathub.org/apps/net.lutris.Lutris)<br>
* [Latest project release](https://github.com/TormStorm/jagex-launcher-linux/releases/)<br>

* Python 3 and Python 3 venv

For Ubuntu users:
```
$ sudo apt install -y python3 python3-venv
```
---

1. Get the requirements from the links above and extract the source code<br>
2. Open Lutris, click the `+` in the top left corner and select `Install from a local install script`<br>
3. Select `jagex-launcher.yml`  and follow the on screen instructions leaving the installation directory as default<br>

### Game Clients

The official clients can be played by download them from the Jagex Launcher<br>
All of the officially approved third party clients are automatically installed<br>

### Steam Deck

Switch to desktop mode by pressing steam, power, switch to desktop and then follow the instructions above<br>
Once the installation has completed do the following steps:<br>

1. Install BoilR from the discover store<br>
2. Select `Import Games` and make sure the Jagex Launcher is checked under Lutris<br>
3. Click the import games button on the bottom left and restart steam<br>
4. Rename the Steam entry to `RuneScape` if playing RuneScape or `OSRS` if playing Old School RuneScape<br>
5. Press the steam button, controller settings, browse community layouts and select a controller layout<br>

If you are using RuneLite on the Steam Deck you can import a properties file to set it up automatically<br>

1. Launch RuneLite, open the configuration menu and select the profiles tab<br>
2. Click `import profile` navigate to `$HOME/Games/jagex-launcher` and open `steamdeck-settings.properties`
3. Double-click the imported profile to select it

### Additional information

For additional information and troubleshooting visit the [Jagex Launcher Linux Wiki](https://github.com/TormStorm/jagex-launcher-linux/wiki)<br>
