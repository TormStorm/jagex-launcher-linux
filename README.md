![](https://runescape.wiki/images/thumb/Jagex_Launcher_icon.png/128px-Jagex_Launcher_icon.png)
# Jagex Launcher Linux [![Discord](https://img.shields.io/discord/828918474784768010)](https://discord.gg/aX7GT2Mkdu)

This repository contains community projects to install the Jagex Launcher and use Jagex Accounts in Linux     
If you have any questions feel free to join my [Discord server](https://discord.gg/aX7GT2Mkdu)  

## [nmlynch94/com.jagexlauncher.JagexLauncher](https://github.com/nmlynch94/com.jagexlauncher.JagexLauncher)
<img src="https://github.com/user-attachments/assets/6d0024d8-fff0-432d-be5d-c0cb3cf3f8b6" width="20"> Installs the Official Jagex Launcher which runs through Wine  
<img src="https://github.com/user-attachments/assets/989790d0-1a47-489d-a666-a46c31148295" width="20"> The New Official Client runs through Wine and is installable via the Jagex Launcher  
<img src="https://github.com/user-attachments/assets/3021bbfd-2e59-41b1-9df7-d275f6e34c65" width="20"> RuneLite & HDOS run natively and are included  
<img src="https://github.com/user-attachments/assets/d461c72e-1fd4-40f1-8f97-6054d9073fd3" width="20"> The RS3 Client runs through Wine and is installable via the Jagex Launcher  

Install the Flatpak:
```
curl -fSsL https://raw.githubusercontent.com/nmlynch94/com.jagexlauncher.JagexLauncher/main/install-jagex-launcher-repo.sh | bash
```
Run the Flatpak from the terminal:
```
flatpak run com.jagexlauncher.JagexLauncher
```
## [TormStorm/jagex-launcher-linux](https://github.com/TormStorm/jagex-launcher-linux/tree/feature)
<img src="https://github.com/user-attachments/assets/6d0024d8-fff0-432d-be5d-c0cb3cf3f8b6" width="20"> Installs the Official Jagex Launcher which runs through Wine  
<img src="https://github.com/user-attachments/assets/989790d0-1a47-489d-a666-a46c31148295" width="20"> The New Official Client runs through Wine and is installable via the Jagex Launcher  
<img src="https://github.com/user-attachments/assets/3021bbfd-2e59-41b1-9df7-d275f6e34c65" width="20"> RuneLite & HDOS run natively and are included  
<img src="https://github.com/user-attachments/assets/d461c72e-1fd4-40f1-8f97-6054d9073fd3" width="20"> The RS3 Client runs through Wine and is installable via the Jagex Launcher  

Install the Jagex Launcher
```
bash <(curl -fSsL https://raw.githubusercontent.com/TormStorm/jagex-launcher-linux/feature/resources/install_script.sh)
```

## [Adamcake/Bolt](https://codeberg.org/Adamcake/Bolt)
<img src="https://github.com/user-attachments/assets/201b579c-cfa6-42f3-89a2-dea4b70022be" width="20"> Native third-party Jagex Launcher  
<img src="https://github.com/user-attachments/assets/989790d0-1a47-489d-a666-a46c31148295" width="20"> The New Official Client runs through Wine and is installable via Bolt  
<img src="https://github.com/user-attachments/assets/3021bbfd-2e59-41b1-9df7-d275f6e34c65" width="20"> RuneLite & HDOS run natively and are included  
<img src="https://github.com/user-attachments/assets/d461c72e-1fd4-40f1-8f97-6054d9073fd3" width="20"> The RS3 Client runs natively and is included  

Install the Flatpak:
```
flatpak install com.adamcake.Bolt
```
Run the Flatpak from the terminal:
```
flatpak run com.adamcake.Bolt
```

## Steam Deck
Switch to desktop mode and install one of the community projects. For new users i would recommend installing Bolt through the Discover app  
Open the application menu, right click the application you installed and select add to Steam. This will add it to your library under `NON-STEAM`  

To search for community controller layouts rename the Steam entry to `RuneScape` if playing RS3 or `OSRS` if playing Old School RuneScape  
If you use [Decky Loader](https://github.com/SteamDeckHomebrew/decky-loader) you can download `SteamGridDB` to add custom artwork to your Steam entry  

### RuneLite

You can import this [properties file](https://github.com/TormStorm/jagex-launcher-linux/blob/main/resources/steamdeck-settings.properties) to get the correct settings for your Steam Deck 

To import a properties file switch to desktop mode, open the Jagex Launcher and start RuneLite  
Open the configuration menu and select the profiles tab. Click `import profile` and navigate to your properties file  

To log in to your RuneLite account switch to desktop mode, open the Jagex Launcher and start RuneLite  
Click the login button at the bottom right of your client and sign in to your account  

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

## Star History

<a href="https://www.star-history.com/#TormStorm/jagex-launcher-linux&type=date&legend=top-left">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=TormStorm/jagex-launcher-linux&type=date&theme=dark&legend=top-left" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=TormStorm/jagex-launcher-linux&type=date&legend=top-left" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=TormStorm/jagex-launcher-linux&type=date&legend=top-left" />
 </picture>
</a>

> [!WARNING]  
> I am not affiliated with Jagex and is not responsible for the maintenance and safety of content produced and hosted by third parties. Any use of third-party sites is at your own risk
