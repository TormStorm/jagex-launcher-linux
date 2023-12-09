![](https://runescape.wiki/images/thumb/Jagex_Launcher_icon.png/128px-Jagex_Launcher_icon.png)
# Jagex Launcher Linux [![Discord](https://img.shields.io/discord/828918474784768010)](https://discord.gg/aX7GT2Mkdu)

This repository contains instruction on how to install the Jagex Launcher in Linux to play RuneScape and Old School RuneScape<br>

> [!IMPORTANT]  
> You need a Jagex Account in order to access the Jagex Launcher

## Official Jagex Launcher

There are multiple Flatpaks available, we recommend using this one from USA-RedDragon:
```
curl -fSsL https://raw.githubusercontent.com/USA-RedDragon/jagex-launcher-flatpak/main/install.sh | bash
```
For more information visit USA-RedDragon's [GitHub page](https://github.com/USA-RedDragon/jagex-launcher-flatpak)<br>
<br>


Alternatively you can use nmlynch94's Flatpak:
```
wget https://raw.githubusercontent.com/nmlynch94/com.jagexlauncher.JagexLauncher/main/install-jagex-launcher.sh && bash install-jagex-launcher.sh && rm install-jagex-launcher.sh
```
For more information visit nmlynch94's [GitHub page](https://github.com/nmlynch94/com.jagexlauncher.JagexLauncher)

## Third-party launcher

If you want to use a native third-party launcher you can install Bolt:<br>
```
flatpak install flathub com.adamcake.Bolt
```

For more information visit adamcake's [Flathub page](https://github.com/flathub/com.adamcake.Bolt)

## Steam Deck
Switch to the desktop and open the application menu. Right click the Jagex Launcher and select add to Steam<br>
Switch back to Gaming Mode, your new shortcut should now be in your library under `Non-Steam`<br>
Rename the Steam entry to `RuneScape` if playing RuneScape or `OSRS` if playing Old School RuneScape<br>
You can configure your controls by going into the game's controller settings and browse community layouts

If you are using RuneLite on the Steam Deck you can import a [properties file](https://github.com/TormStorm/jagex-launcher-linux/blob/main/resources/steamdeck-settings.properties) to set it up automatically<br>

Install [Flatseal](https://flathub.org/apps/com.github.tchx84.Flatseal) and open it. Select the Jagex Launcher and enable `All user files` under Filesystem<br>
Launch RuneLite, open the configuration menu and select the profiles tab<br>
Click `import profile` navigate to your download folder and open `steamdeck-config.properties`<br>
Double-click the imported profile to select it<br>
Open Flatseal again, select the Jagex Launcher and disable `All user files`<br>

### Additional information

For more information and troubleshooting visit the [Jagex Launcher Linux Wiki](https://github.com/TormStorm/jagex-launcher-linux/wiki)

> [!WARNING]  
> I am not affiliated with Jagex and is not responsible for the maintenance and safety of content produced and hosted by third parties. Any use of third-party sites is at your own risk
