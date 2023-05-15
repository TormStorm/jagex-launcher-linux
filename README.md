# Jagex Launcher Linux

> **Warning**<br>
> This branch may not contain working or complete instructions. Please use the main branch

This repo contains instruction on how to install the Jagex Launcher in Linux. It also sets up the Flatpak version of RuneScape as well as RuneLite for Old Shool RuneScape.<br>

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
Install the Jagex Launcher with Lutris

# Requirements

- [Lutris](https://lutris.net/downloads)
- (optional) [Flatpak](https://flatpak.org/setup/) and [Flatseal](https://flathub.org/apps/com.github.tchx84.Flatseal)
  - Only needed if you want to run RS3 in flatpak, or you want to use flatpak Lutris
  - Using lutris from your disto's package manager is recommended instead of Flatpak
  - Steam deck comes pre-installed with flatpak and does not allow installing from pacman by default so flatpak is recommended in that case.

## Steam deck tips (skip if not on Steam Deck)
Switch to desktop mode by pressing Steam -> Power -> Switch to Desktop  
Then you can just follow the guide like normal

Recommend installing AnyDesk from the Discover Store and also on your PC to do the installation remotely  
Makes installation steps that involve the terminal much more manageable   

If you are using RuneLite, there are many resolution and wonky ui issues with Steam Deck out of the box. The installer creates a properties file you can import to solve most of these issues. You can import this by clicking the wrench in the top right of RuneLite, clicking the "profiles" tab, then clicking "import profile" and select the file called steamdeck-config.properties in the installation directory (usually /home/<user>/Games/jagex-launcher). Credit to https://www.reddit.com/r/2007scape/comments/yzbuwc/psa_perfect_runelite_settings_for_steam_deck/ for these settings.  
The file selector can be very wonky in game mode, so recommend doing this in Desktop mode right after installation.  

In testing I sometimes had an issue where lutris couldn't open file selectors/popups. This was fixed with `systemctl restart --user xdg-desktop-portal` 

## Configuring flatseal (skip if not using Flatpak Lutris)
Install Lutris and Flatseal from flathub  
Launch Flatseal and select Lutris. Under Filesystem enable All user files.

## Running the installer
Navigate to the [Jagex Launcher](https://lutris.net/games/jagex-launcher/) page on the Lutris website  
Click install and open it in Lutris.  
If that does not work, you can also click the + in the top left of Lutris and use the Search feature  
Follow the prompts carefully. Leave the default installation path. 

After you click install, the Jagex Launcher wizard will appear to freeze. This is expected, and the installer still works in the background. To continue, you will need to force quit that window after waiting about one minute. You can do so the following ways:  
  - xkill - Some distros have this pre-packaged. Simply type `xkill` in a terminal and then click on the install wizard
  - shell command if you don't have xkill (steam deck does not):  
```ps aux | grep 'cache/lutris/installer/jagex-launcher/jagexlauncher/' | grep -v grep | awk '{print $2}' | xargs kill```

Once that is complete. You should be able to launch from Lutris and login!  
RuneLite is pre-configured

# RuneScape
Run the Flatpak RuneScape game client

# Old School RuneScape
Run the RuneLite game client

# Steam Deck
<br>

# Troubleshooting
<br>

# References
<br>
