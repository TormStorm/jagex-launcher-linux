#!/usr/bin/env bash
set -euo pipefail

# Directories
BASE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/jagex-launcher"
GAMES_DIR="${BASE_DIR}/games"
HDOS_DIR="${GAMES_DIR}/hdos"
JAVA_DIR="${BASE_DIR}/java"
PREFIX_DIR="${BASE_DIR}/prefix"
RUNELITE_DIR="${GAMES_DIR}/runelite"
WINE_DIR="${BASE_DIR}/.wine"

# Links
EULA_URL="https://www.jagex.com/en-GB/terms/eula"
INSTALLER_URL="https://github.com/TormStorm/jagex-launcher-linux/releases/download/v1.0.1/installer.py"
JAVA_URL="https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_linux-x64_bin.tar.gz"
RUNELITE_URL="https://github.com/runelite/launcher/releases/download/2.6.9/RuneLite.jar"
HDOS_URL="https://cdn.hdos.dev/launcher/latest/hdos-launcher.jar"
STEAMDECK_URL="https://github.com/TormStorm/jagex-launcher-linux/releases/download/v1.0.1/steamdeck-settings.properties"
WINE_URL="https://github.com/Kron4ek/Wine-Builds/releases/download/11.1/wine-11.1-amd64-wow64.tar.xz"
WINE_MONO_URL="https://dl.winehq.org/wine/wine-mono/9.0.0/wine-mono-9.0.0-x86.msi"
WINE_GECKO_URL="https://dl.winehq.org/wine/wine-gecko/2.47.4/wine-gecko-2.47.4-x86_64.msi"

# Helpers
zen_nospam() { zenity 2> >(grep -v 'Gtk' >&2) "$@"; }

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing dependency: $1"
    echo "Please install it and re-run."
    exit 1
  }
}

is_installed() {
  [[ -e "${BASE_DIR}" ]]
}

eula_gate() {
  xdg-open "$EULA_URL" >/dev/null 2>&1 &

  while true; do
    if zen_nospam --question \
      --title="Jagex Launcher Installer" \
      --text="This is an unofficial installer. Use at your own risk.

The Jagex EULA has been opened in your browser:
$EULA_URL

By continuing, you confirm you have read and accept the EULA."; then
      return 0
    fi

    zen_nospam --error \
      --title="Jagex Launcher Installer" \
      --text="EULA must be accepted before continuing."
  done
}


select_clients() {
  local choice
  choice="$(zen_nospam --title="Jagex Launcher Installer" --width=720 --height=420 \
    --list --checklist \
    --text="Select which clients to install:" \
    --column "Install" --column "Client" --column "Notes" \
    FALSE "RuneLite" "Install RuneLite" \
    FALSE "HDOS"     "Install HDOS" \
    --separator=" " \
    || true)"

  INSTALL_RUNELITE=0
  INSTALL_HDOS=0

  for c in $choice; do
    case "$c" in
      RuneLite) INSTALL_RUNELITE=1 ;;
      HDOS)     INSTALL_HDOS=1 ;;
    esac
  done
}

select_components() {

  if [[ "${INSTALL_RUNELITE:-0}" -eq 1 ]]; then
    local choice
    choice="$(zen_nospam --title="Jagex Launcher Installer" --width=720 --height=420 \
      --list --checklist \
      --text="Select which components to install:" \
      --column "Install" --column "Components" --column "Notes" \
      FALSE "SteamDeck" "Install RuneLite settings for Steam Deck" \
      --separator=" " \
      || true)"

    INSTALL_STEAMDECK=0

    for c in $choice; do
      case "$c" in
        SteamDeck) INSTALL_STEAMDECK=1 ;;
      esac
    done
  fi

}

create_dirs() {

  mkdir -p "$BASE_DIR" "$WINE_DIR" "$PREFIX_DIR" "$GAMES_DIR"

}

download_files() {

  curl -fL --output-dir "$WINE_DIR" -O "$WINE_URL"
  curl -fL --output-dir "$WINE_DIR" -O "$WINE_MONO_URL"
  curl -fL --output-dir "$WINE_DIR" -O "$WINE_GECKO_URL"

  curl -fL --output-dir "$BASE_DIR" -O "$INSTALLER_URL"

  if [[ "${INSTALL_RUNELITE:-0}" -eq 1 || "${INSTALL_HDOS:-0}" -eq 1 ]]; then
    mkdir -p "$JAVA_DIR"
    curl -fL --output-dir "$JAVA_DIR" -O "$JAVA_URL"
  fi

  if [[ "${INSTALL_RUNELITE:-0}" -eq 1 ]]; then
    mkdir -p "$RUNELITE_DIR"
    curl -fL --output-dir "$RUNELITE_DIR" -O "$RUNELITE_URL"
  fi

  if [[ "${INSTALL_RUNELITE:-0}" -eq 1 && "${INSTALL_STEAMDECK:-0}" -eq 1 ]]; then
    curl -fL --output-dir "$RUNELITE_DIR" -O "$STEAMDECK_URL"
  fi

  if [[ "${INSTALL_HDOS:-0}" -eq 1 ]]; then
    mkdir -p "$HDOS_DIR"
    curl -fL --output-dir "$HDOS_DIR" -O "$HDOS_URL"
  fi

}

extract_files() {

  local wine="$WINE_DIR/$(basename "$WINE_URL")"
  if tar -xJf "$wine" -C "$WINE_DIR"; then
    rm -f "$wine"
  fi

  if [[ "${INSTALL_RUNELITE:-0}" -eq 1 || "${INSTALL_HDOS:-0}" -eq 1 ]]; then
    local java="$JAVA_DIR/$(basename "$JAVA_URL")"
    if tar -xzf "$java" -C "$JAVA_DIR"; then
      rm -f "$java"
    fi
  fi

}

create_prefix() {
  local winebin="$WINE_DIR/wine-11.1-amd64-wow64/bin"
  local wineprefix="$PREFIX_DIR/jagex-launcher"

  mkdir -p "$wineprefix"

  export WINEPREFIX="$wineprefix"
  export WINEARCH=win64

  export MESA_SHADER_CACHE_DIR="$wineprefix"
  export DXVK_STATE_CACHE_PATH="$wineprefix/dxvk_shader_cache"
  mkdir -p "$DXVK_STATE_CACHE_PATH"

  "$winebin/wineboot"

  "$winebin/wine" msiexec /i "$WINE_DIR/$(basename "$WINE_MONO_URL")" /qn
  "$winebin/wine" msiexec /i "$WINE_DIR/$(basename "$WINE_GECKO_URL")" /qn

  "$winebin/wineboot" -u
}

install_launcher() {
  local installer="$BASE_DIR/installer.py"
  local venv="$BASE_DIR/.venv"

  python3 -m venv "$venv"
  "$venv/bin/pip" install requests jwcrypto cryptography

  ( cd "$BASE_DIR" && "$venv/bin/python" "$installer" )

  rm -f "$installer"
}

run_launcher() {
  echo "Running the Jagex Launcher"

  local winebin="$WINE_DIR/wine-11.1-amd64-wow64/bin"
  local wineprefix="$PREFIX_DIR/jagex-launcher"
  local exe="$BASE_DIR/JagexLauncher.exe"

  export WINEPREFIX="$wineprefix"
  export WINEARCH=win64

  export MESA_SHADER_CACHE_DIR="$wineprefix"
  export DXVK_STATE_CACHE_PATH="$wineprefix/dxvk_shader_cache"
  mkdir -p "$DXVK_STATE_CACHE_PATH"

  "$winebin/wine" "$exe" --disable-gpu --disable-software-rasterizer >/dev/null 2>&1
}

uninstall() {

  if [[ -d "$BASE_DIR" ]]; then
    rm -rf "$BASE_DIR"
    zen_nospam --info --title="Success" --text="Jagex Launcher uninstalled successfully."

  else
    zen_nospam --error --text="The Jagex Launcher is not installed."
  fi
}

browse() {

  if [[ -d "$BASE_DIR" ]]; then
    xdg-open "$BASE_DIR" >/dev/null 2>&1 &
  else
    zen_nospam --error --text="The Jagex Launcher is not installed."
  fi

}

configure() {

  if [[ -d "$RUNELITE_DIR" ]]; then
    echo "Configuring RuneLite"
  else
    zen_nospam --error --text="RuneLite is not installed."
  fi

}


do_install() {

  if [[ -d "$BASE_DIR" ]]; then
    zen_nospam --error --text="The Jagex Launcher is already installed."
    return 0
  fi

  (

    echo "10"  ; echo "# Accepting EULA"
    eula_gate

    echo "20" ; echo "# Select clients"
    select_clients

    echo "30" ; echo "# Select components"
    select_components

    echo "40" ; echo "# Creating directories"
    create_dirs

    echo "50" ; echo "# Downloading files"
    download_files

    echo "60" ; echo "# Extracting files"
    extract_files

    echo "70" ; echo "# Configuring Wine"
    create_prefix

    echo "80" ; echo "# Installing Jagex Launcher"
    install_launcher

    echo "90" ; echo "# Done"
    zen_nospam --info --title="Jagex Launcher Installer" --text="Installation completed succesfully."

    echo "100"; echo "# Running Jagex Launcher"
    run_launcher

  ) | zen_nospam --progress --title="Jagex Launcher Installer" --width=720 --no-cancel --percentage=0

  exit 0
}


main_menu() {
  while true; do
    local option
    if option=$(zen_nospam --title="Jagex Launcher Installer" \
        --width=720 --height=420 \
        --list --radiolist --hide-header \
        --text="Select an option:" \
        --column "Pick" --column "Action" --column "Info" \
        TRUE  "Install" "Install the Jagex Launcher" \
        FALSE "Manage"  "Manage the installation" \
        FALSE "Exit"    "Exit"); then
      :
    else
      exit 0
    fi

    case "$option" in
      "Install") do_install ;;
      "Manage")  manage ;;
      "Exit")    exit 0 ;;
      *)  ;;
    esac
  done
}

manage() {
  while true; do
    local option
    if option=$(zen_nospam --title="Jagex Launcher Installer" \
        --width=720 --height=420 \
        --list --radiolist --hide-header \
        --text="Manage:" \
        --column "Pick" --column "Action" --column "Info" \
        FALSE "Browse"    "Browse app data" \
        FALSE "Configure"    "Configure RuneLite" \
        FALSE "Uninstall" "Uninstall the Jagex Launcher" \
        FALSE "Back"      "Go back to the previous menu"); then
      :
    else
      break
    fi

    case "$option" in

      "Browse") browse ;;
      "Configure") configure ;;
      "Uninstall") uninstall; break ;;
      "Back") break ;;
      *) ;;
    esac
  done
}

# Entry
require_cmd zenity
require_cmd python3
require_cmd curl
require_cmd sha256sum
require_cmd tar
# runtime extraction helper
if ! command -v unzstd >/dev/null 2>&1; then
  require_cmd zstd
fi

main_menu
