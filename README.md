# Jagex launcher for Linux

This repo contains instruction on how to install the Jagex Launcher on linux with RuneLite through Wine.


** **This is a work in progress** **
<br>If you have any problems with the instucions please create a pull request and i will try to fix it.

**This document does _NOT_ contain any links. Make sure to download the files from correct sources**

## Why i created this repo

Since Jagex doesn't seem to be interested in making a native Jagex launcher for linux, as well as not providing any documentation on how to make it run in linux i though i would make a step by step instruction. Hopefully this guide won't be needed in the future, but until then this provides a way for linux users to use the Jagex Launcher. 

# How To:

## Requirements
- Wine
- WineTricks
- Jagex Launcher installed files
- RuneLite (optional)

## Installing .NET Framework
Open WineTricks and choose "Select the default wineprefix"
<img src="/assets/images/wineprefix.png" width="75%">


Next select "Install a Windows DLL or component"
<img src="/assets/images/component.png" width="75%">


Select "dotnet48". Ignore any errors and keep pressing OK until you get to the .NET Framework 4 Setup 
<img src="/assets/images/dotnet48.png" width="75%">

Accept the license terms and click install
<br>
<img src="/assets/images/dotnet4setup.png" width="60%">


You might get a warning, but it can safely be ignored
<br>
<img src="/assets/images/dotnetwarning.png" width="60%">

Accept the license terms and click install
<br>
<img src="/assets/images/dotnet4.8setup.png" width="60%">

## Installing the launcher
To install the Jagex Launcher you need the files 
