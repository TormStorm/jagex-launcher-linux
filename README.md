![](https://runescape.wiki/images/thumb/Jagex_Launcher_icon.png/128px-Jagex_Launcher_icon.png)
# Jagex Launcher Linux [![Discord](https://img.shields.io/discord/828918474784768010)](https://discord.gg/aX7GT2Mkdu)

This repository contains community projects to install the Jagex Launcher and use Jagex Accounts in Linux     
If you have any questions feel free to join my [Discord server](https://discord.gg/aX7GT2Mkdu)  

### Jagex Launcher

Community projects that package the official Jagex Launcher   

* [USA-RedDragon/jagex-launcher-flatpak](https://github.com/USA-RedDragon/jagex-launcher-flatpak)
* [nmlynch94/com.jagexlauncher.JagexLauncher](https://github.com/nmlynch94/com.jagexlauncher.JagexLauncher)

<img src="https://github.com/TormStorm/jagex-launcher-linux/assets/35997481/8cf8913f-b0c9-4d16-9eb5-2e7e6847f433" width=750px>

### Bolt Launcher

Native third-party alternative to the Jagex Launcher

* [Adamcake/Bolt](https://bolt.adamcake.com)

<img src="https://github.com/TormStorm/jagex-launcher-linux/assets/35997481/970f4ee0-8e6b-44de-8757-0b995d73f921" width=750px>

### Old installation methods

Install the official Jagex Launcher manually or via Lutris

* [TormStorm/jagex-launcher-linux/wiki/old-installation-methods](https://github.com/TormStorm/jagex-launcher-linux/wiki/old-installation-methods)

## Steam Deck
Install one of the community projects above  
For the Official Jagex Launcher install it by following the instructions in the README of the respective repo  
For the Bolt Launcher install it through the Discover app (recommended)  

Switch to desktop mode and open the application menu. Right click the application and select add to Steam  
A new Steam entry will be added to your library under `NON-STEAM`  

Rename the Steam entry to `RuneScape` if playing RuneScape or `OSRS` if playing Old School RuneScape  
Now you can go into the game's controller settings and browse community layouts or make your own   

If you use [Decky Loader](https://github.com/SteamDeckHomebrew/decky-loader) you can download `SteamGridDB` to add custom artwork to your Steam entry  

### RuneLite

You can import a [properties file](https://github.com/TormStorm/jagex-launcher-linux/blob/main/resources/steamdeck-settings.properties) or log in to import your profiles  
While in desktop mode open the Jagex Launcher and start RuneLite  

To import a properties file open the configuration menu and select the profiles tab  
Click `import profile` navigate to your properties file and open it  

To log in to your RuneLite account click the login button at the bottom right of your client  
A browser will open where you will be able to sign in and import your profiles  

## Chromebook

Set up [Linux on your Chromebook](https://support.google.com/chromebook/answer/9145439)   
Open the Linux terminal and run the following command to install Java and Bolt:  
```
sudo apt install default-jdk && sudo apt install flatpak && flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo && flatpak install flathub com.adamcake.Bolt
```
Run Bolt from the terminal:   
```
flatpak run com.adamcake.Bolt --no-sandbox
```

> [!WARNING]  
> I am not affiliated with Jagex and is not responsible for the maintenance and safety of content produced and hosted by third parties. Any use of third-party sites is at your own risk
