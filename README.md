# Jagex Launcher Linux

> **Warning**<br>
> This branch may not contain working or complete instructions. Please use the main branch

This repo contains instruction on how to install the Jagex Launcher in Linux<br>

## Disclaimer

I am not responsible for the maintenance and safety of content produced and hosted by third parties and any use of third-party sites is at your own risk.

# Table of contents

- [Jagex Launcher](#jagex-launcher)
- [RuneScape client](#runescape)
- [Old School RuneScape client](#old-school-runescape)
- [Steam Deck](#steam-deck)
- [Troubleshooting](#troubleshooting)
- [References](#references)

# Jagex Launcher

## Requirements

- [Lutris](https://lutris.net/downloads)

> **Note**<br>
> It is recommended to install Lutris from your disto's package manager<br>
> If you use the Flatpak version of Lutris you will not be able to use the Flatpak version of RuneScape


## Installation
Open Lutris and click the + in the top left corner<br>
Select `Search the Lutris website for installers` and search for `Jagex Launcher`<br>
Make sure to leave the default installation path

After clicking install the installer will appear to freeze. This is expected, and the installer still works in the background<br>
After waiting about one minute you can close the Jagex Launcher with the following command<br>
```ps aux | grep 'cache/lutris/installer/jagex-launcher/jagexlauncher/' | grep -v grep | awk '{print $2}' | xargs kill```

After you click install, the Jagex Launcher wizard will appear to freeze. This is expected, and the installer still works in the background.<br>
To continue, you will need to force quit that window after waiting about one minute<br>

Once the installation is complete you should be able to launch the Jagex Launcher and log in

If you are using the flatpak version of Lutris make sure to also install Flatseal<br>
Launch Flatseal and select Lutris. Under Filesystem enable all user files

# RuneScape

The Flatpak version of the RuneScape client is automaticly installed, and can be played by selecting it in the Jagex Launcher and pressing play<br>

# Old School RuneScape

The official Old School RuneScape client can be played by selecting it from the dropdown menu in the Jagex Launcher and selecting install<br>
The RuneLite client is automaticly installed, and can be played by selecting it from the dropdown menu and pressing play

# Steam Deck
Switch to desktop mode by pressing Steam -> Power -> Switch to Desktop  
Then you can just follow the guide like normal
Once that is done, install Boilr from the discover store.
Choose Import Games on the left, then make sure "Jagex Launcher" is checked in the list and click the button on the bottom left.
Restart steam
Find the new entry for "Jagex Launcher". 
Rename to RuneScape if playing RS3
Rename to OSRS or RuneLite if playing OSRS
This is because steam deck searches for control layouts based on game name
Reboot to game mode and launch the new entry. 
Press the steam button -> Controller Settings -> Browse community layouts
Choose a layout that looks good for you and then you should be good to start playing!

Recommend installing AnyDesk from the Discover Store and also on your PC to do the installation remotely  
Makes installation steps that involve the terminal much more manageable   

If you are using RuneLite, there are many resolution and wonky ui issues with Steam Deck out of the box. The installer creates a properties file you can import to solve most of these issues. You can import this by clicking the wrench in the top right of RuneLite, clicking the "profiles" tab, then clicking "import profile" and select the file called steamdeck-config.properties in the installation directory (usually /home/<user>/Games/jagex-launcher). The file selector can be very wonky in game mode, so recommend doing this in Desktop mode right after installation[^1]

# Troubleshooting
  
Exit with return code 256<br>
Delete the ```lutris-GE-Proton8-5-x86_64``` folder inside /data/lutris/runners/wine and restart the installation
  
Lutris can't open file selectors/popups<br>
Run the following command: `systemctl restart --user xdg-desktop-portal`

Audio issues<br>
If you are using Flatpak you can add this to other files in Flatseal ```xdg-run/pipewire-0``` and then tweak ```PULSE_LATENCY_MSEC=X```[^2]<br>

# References
[^1]: [PSA: Perfect RuneLite settings for Steam Deck.](https://www.reddit.com/r/2007scape/comments/yzbuwc/psa_perfect_runelite_settings_for_steam_deck/)
[^2]: [Audio issues with pipewire](https://twitter.com/fe_calmata/status/1650831866046316549)

