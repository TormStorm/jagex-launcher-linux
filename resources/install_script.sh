#!/usr/bin/env bash
set -euo pipefail

APP_NAME="Jagex Launcher Linux"
APP_ID="jagex-launcher-linux"

# Directories
BASE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/jagex-launcher-linux"
STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/jagex-launcher-linux"
WINE_DIR="${BASE_DIR}/wine"
JRE_DIR="${BASE_DIR}/jre"
PREFIX_DIR="${BASE_DIR}/prefix"
BIN_DIR="${BASE_DIR}/bin"
JAGEX_DIR="${PREFIX_DIR}/drive_c/Program Files (x86)/Jagex Launcher"
GAMES_DIR="${JAGEX_DIR}/Games"
RUNELITE_DIR="${GAMES_DIR}/RuneLite"
HDOS_DIR="${GAMES_DIR}/HDOS"

# Files
JAGEX_EXE="${JAGEX_DIR}/JagexLauncher.exe"
LOG_FILE="${STATE_DIR}/install.log"
ICON_FILE="${JAGEX_DIR}/jagex-launcher.png"
LAUNCHER_SCRIPT="${BIN_DIR}/jagex-launcher-linux"
DESKTOP_FILE="${HOME}/.local/share/applications/${APP_ID}.desktop"
WINE_BIN="${WINE_DIR}/bin/wine"
WINEPATH_BIN="${WINE_DIR}/bin/winepath"
JAVA_BIN="${JRE_DIR}/bin/java"
WINE_SOURCE_FILE="${WINE_DIR}/.source"
JAVA_SOURCE_FILE="${JRE_DIR}/.source"

# Links
EULA_URL="https://www.jagex.com/en-GB/terms/eula"
WINE_URL="https://github.com/GloriousEggroll/wine-ge-custom/releases/download/GE-Proton8-26/wine-lutris-GE-Proton8-26-x86_64.tar.xz"
INSTALLER_URL="https://raw.githubusercontent.com/TormStorm/jagex-launcher-linux/main/resources/installer.py"
JRE_URL="https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.19%2B10/OpenJDK17U-jre_x64_linux_hotspot_17.0.19_10.tar.gz"
RUNELITE_URL="https://github.com/runelite/launcher/releases/download/2.7.7/RuneLite.jar"
HDOS_URL="https://cdn.hdos.dev/launcher/latest/hdos-launcher.jar"
ICON_URL="https://oldschool.runescape.wiki/w/Special:Redirect/file/Jagex_Launcher_icon.png"

INSTALLING=0

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing dependency: $1"
    echo "Please install it and re-run."
    exit 1
  }
}

die() {
  echo "Error: $*" >&2
  echo "Log file: ${LOG_FILE}" >&2
  exit 1
}

cleanup_on_error() {
  local status=$?
  if [[ $status -ne 0 && "${INSTALLING}" = "1" ]]; then
    echo
    echo "Installation failed. Removing downloaded and installed files."
    rm -rf "$BASE_DIR"
    rm -f "$DESKTOP_FILE"
    echo "Cleanup complete. The installation log was kept at: ${LOG_FILE}"
  fi
  exit "$status"
}
trap cleanup_on_error EXIT

log_section() {
  {
    echo
    echo "== $* =="
    date '+%Y-%m-%d %H:%M:%S %z'
  } >>"$LOG_FILE"
}

log_step() {
  echo "$*" >>"$LOG_FILE"
}

is_installed() {
  [[ -f "$WINE_DIR/.source" && -f "$JRE_DIR/.source" && -f "$JAGEX_EXE" ]]
}

installed_source() {
  local file="$1"
  [[ -f "$file" ]] && head -n 1 "$file"
  return 0
}

source_changed() {
  local current="$1" installed="$2"
  [[ -z "$installed" || "$current" != "$installed" ]]
}

confirm() {
  local prompt="$1" answer

  if [[ ! -r /dev/tty ]]; then
    echo "Error: this installer needs an interactive terminal." >&2
    return 1
  fi

  while true; do
    printf '%s [y/N]: ' "$prompt" > /dev/tty
    IFS= read -r answer < /dev/tty || return 1
    case "${answer:-n}" in
      y|Y|yes|YES|Yes) return 0 ;;
      n|N|no|NO|No) return 1 ;;
      *) printf 'Please answer y or n.\n' > /dev/tty ;;
    esac
  done
}

eula_gate() {
  echo "Opening the Jagex EULA in your default browser."
  echo "EULA: ${EULA_URL}"
  if command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$EULA_URL" >/dev/null 2>&1 &
  fi
  confirm "Do you accept the Jagex EULA and want to continue?" || die "EULA must be accepted before continuing."
}

create_dirs() {
  mkdir -p \
    "$BASE_DIR" \
    "$STATE_DIR" \
    "$WINE_DIR" \
    "$JRE_DIR" \
    "$PREFIX_DIR" \
    "$BIN_DIR" \
    "$JAGEX_DIR" \
    "$GAMES_DIR" \
    "$RUNELITE_DIR" \
    "$HDOS_DIR" \
    "$(dirname "$DESKTOP_FILE")"
}

start_log_entry() {
  local title="$1"
  mkdir -p "$STATE_DIR"
  {
    echo
    echo "============================================================"
    echo "${APP_NAME}: ${title}"
    date '+%Y-%m-%d %H:%M:%S %z'
    uname -a
    echo "============================================================"
  } >>"$LOG_FILE"
}

create_log() {
  mkdir -p "$STATE_DIR"
  rm -f "$LOG_FILE"
  start_log_entry "Fresh install"
}

download_file() {
  local label="$1" url="$2" output="$3"
  mkdir -p "$(dirname "$output")"
  log_section "Download: ${label}"
  log_step "URL: ${url}"
  log_step "Output: ${output}"

  python3 - "$url" "$output" "$label" "$LOG_FILE" <<'PY'
import os
import sys
import time
import urllib.request

url, output, label, log_file = sys.argv[1:]

def human(size):
    units = ["B", "KiB", "MiB", "GiB"]
    value = float(size)
    for unit in units:
        if value < 1024 or unit == units[-1]:
            if unit == "B":
                return f"{int(value)} {unit}"
            return f"{value:.1f} {unit}"
        value /= 1024

try:
    request = urllib.request.Request(url, headers={"User-Agent": "jagex-launcher-linux-installer"})
    with urllib.request.urlopen(request) as response:
        total = int(response.headers.get("Content-Length") or 0)
        downloaded = 0
        last_update = 0.0
        with open(output, "wb") as handle:
            while True:
                chunk = response.read(1024 * 256)
                if not chunk:
                    break
                handle.write(chunk)
                downloaded += len(chunk)
                now = time.monotonic()
                if now - last_update >= 0.1 or downloaded == total:
                    if total:
                        status = f"{downloaded * 100 / total:5.1f}% ({human(downloaded)} / {human(total)})"
                    else:
                        status = human(downloaded)
                    print(f"\r  - {label}: {status}\033[K", end="", flush=True)
                    last_update = now
    if total:
        status = f"100.0% ({human(downloaded)} / {human(total)})"
    else:
        status = human(downloaded)
    print(f"\r  - {label}: {status}\033[K")
    with open(log_file, "a", encoding="utf-8") as log:
        log.write(f"Downloaded {downloaded} bytes.\n")
except Exception as exc:
    print(f"\r  - {label}: failed\033[K")
    with open(log_file, "a", encoding="utf-8") as log:
        log.write(f"ERROR: {exc}\n")
    sys.exit(1)
PY
}

download_files() {
  echo
  echo "Downloading"
  download_file "Wine runtime" "$WINE_URL" "$WINE_DIR/$(basename "$WINE_URL")"
  download_file "Jagex installer" "$INSTALLER_URL" "$JAGEX_DIR/installer.py"
  download_file "Java runtime" "$JRE_URL" "$JRE_DIR/$(basename "$JRE_URL")"
  download_file "RuneLite" "$RUNELITE_URL" "$RUNELITE_DIR/RuneLite.jar"
  download_file "HDOS" "$HDOS_URL" "$HDOS_DIR/HDOS.jar"
  download_file "Jagex Launcher icon" "$ICON_URL" "$ICON_FILE"
}

run_step() {
  local label="$1"
  shift
  printf '  - %s... ' "$label"
  log_section "$label"
  if "$@" >>"$LOG_FILE" 2>&1; then
    echo "done"
  else
    echo "failed"
    return 1
  fi
}

extract_wine() {
  local wine_archive="$WINE_DIR/$(basename "$WINE_URL")"
  tar -xJf "$wine_archive" -C "$WINE_DIR" --strip-components=1
  rm -f "$wine_archive"
  [[ -x "$WINE_BIN" ]] || die "Wine was extracted, but ${WINE_BIN} was not found."
  echo "$WINE_URL" > "$WINE_SOURCE_FILE"
}

extract_java() {
  local jre_archive="$JRE_DIR/$(basename "$JRE_URL")"
  tar -xzf "$jre_archive" -C "$JRE_DIR" --strip-components=1
  rm -f "$jre_archive"
  [[ -x "$JAVA_BIN" ]] || die "Java was extracted, but ${JAVA_BIN} was not found."
  echo "$JRE_URL" > "$JAVA_SOURCE_FILE"
}

wine_env() {
  export WINEPREFIX="$PREFIX_DIR"
  export WINEARCH=win64
  export WINEDLLOVERRIDES="jscript=n,dxgi=b"
  export WINEDEBUG="-all"
  export PATH="$WINE_DIR/bin:$JRE_DIR/bin:$PATH"
  export LD_LIBRARY_PATH="$WINE_DIR/lib:$WINE_DIR/lib64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
  export JAVA_HOME="$JRE_DIR"
}

create_prefix() {
  wine_env
  "$WINE_BIN" wineboot -u
}

install_launcher() {
  local installer="$JAGEX_DIR/installer.py"
  mkdir -p "$JAGEX_DIR"
  ( cd "$JAGEX_DIR" && python3 "$installer" )
  rm -f "$installer"
}

install_runelite() {
  mkdir -p "$RUNELITE_DIR"

  cat > "$RUNELITE_DIR/RuneLite.exe" <<EOF_RUNELITE
#!/usr/bin/env bash
set -euo pipefail
ROOT="${BASE_DIR}"
RUNELITE_HOME="${RUNELITE_DIR}"
mkdir -p "\$RUNELITE_HOME"
export HOME="\$RUNELITE_HOME"
export XDG_DATA_HOME="\$RUNELITE_HOME/.local/share"
export XDG_CONFIG_HOME="\$RUNELITE_HOME/.config"
export XDG_CACHE_HOME="\$RUNELITE_HOME/.cache"
exec "\$ROOT/jre/bin/java" -Duser.home="\$RUNELITE_HOME" -jar "\$RUNELITE_HOME/RuneLite.jar" "\$@" -J-Duser.home="\$RUNELITE_HOME"
EOF_RUNELITE

  chmod +x "$RUNELITE_DIR/RuneLite.exe"
}

install_hdos() {
  mkdir -p "$HDOS_DIR"

  cat > "$HDOS_DIR/HDOS.exe" <<EOF_HDOS
#!/usr/bin/env bash
set -euo pipefail
ROOT="${BASE_DIR}"
HDOS_HOME="${HDOS_DIR}"
mkdir -p "\$HDOS_HOME"
export HOME="\$HDOS_HOME"
export XDG_DATA_HOME="\$HDOS_HOME/.local/share"
export XDG_CONFIG_HOME="\$HDOS_HOME/.config"
export XDG_CACHE_HOME="\$HDOS_HOME/.cache"
exec "\$ROOT/jre/bin/java" -Dapp.user.home="\$HDOS_HOME" -jar "\$HDOS_HOME/HDOS.jar" "\$@"
EOF_HDOS

  chmod +x "$HDOS_DIR/HDOS.exe"
}

register_clients() {
  wine_env
  local runelite_win hdos_win
  runelite_win="$("$WINEPATH_BIN" -w "$RUNELITE_DIR")"
  hdos_win="$("$WINEPATH_BIN" -w "$HDOS_DIR")"

  "$WINE_BIN" reg add 'HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\RuneLite Launcher_is1' \
    /v 'InstallLocation' /t REG_SZ /d "$runelite_win" /f

  "$WINE_BIN" reg add 'HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\HDOS Launcher_is1' \
    /v 'InstallLocation' /t REG_SZ /d "$hdos_win" /f
}

write_launcher() {
  cat > "$LAUNCHER_SCRIPT" <<EOF_LAUNCH
#!/usr/bin/env bash
set -euo pipefail
ROOT="${BASE_DIR}"
WINE="\$ROOT/wine"
JAVA="\$ROOT/jre"
PREFIX="\$ROOT/prefix"
JAGEX_EXE="\$PREFIX/drive_c/Program Files (x86)/Jagex Launcher/JagexLauncher.exe"
export WINEPREFIX="\$PREFIX"
export WINEARCH="win64"
export WINEDLLOVERRIDES="jscript=n,dxgi=b"
export WINEDEBUG="-all"
export PATH="\$WINE/bin:\$JAVA/bin:\$PATH"
export LD_LIBRARY_PATH="\$WINE/lib:\$WINE/lib64\${LD_LIBRARY_PATH:+:\$LD_LIBRARY_PATH}"
export JAVA_HOME="\$JAVA"
exec "\$WINE/bin/wine" "\$JAGEX_EXE" "\$@"
EOF_LAUNCH
  chmod +x "$LAUNCHER_SCRIPT"
}

write_desktop_entry() {
  local icon_value="application-x-executable"
  [[ -f "$ICON_FILE" ]] && icon_value="$ICON_FILE"

  cat > "$DESKTOP_FILE" <<EOF_DESKTOP
[Desktop Entry]
Type=Application
Name=Jagex Launcher
Comment=Jagex Launcher running through Wine
Exec=${LAUNCHER_SCRIPT}
Icon=${icon_value}
Terminal=false
Categories=Game;
StartupNotify=true
StartupWMClass=JagexLauncher.exe
EOF_DESKTOP
  chmod 0644 "$DESKTOP_FILE"

  if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "${HOME}/.local/share/applications" || true
  fi
}

install_shortcuts() {
  write_launcher
  write_desktop_entry
}


update_dependencies() {
  local update_wine="$1" update_java="$2"
  start_log_entry "Dependency update"

  echo
  if [[ "$update_wine" = "yes" ]]; then
    rm -rf "$WINE_DIR"
    mkdir -p "$WINE_DIR"
    download_file "Downloading Wine runtime" "$WINE_URL" "$WINE_DIR/$(basename "$WINE_URL")"
  fi
  if [[ "$update_java" = "yes" ]]; then
    rm -rf "$JRE_DIR"
    mkdir -p "$JRE_DIR"
    download_file "Downloading Java runtime" "$JRE_URL" "$JRE_DIR/$(basename "$JRE_URL")"
  fi

  if [[ "$update_wine" = "yes" ]]; then
    run_step "Installing Wine runtime" extract_wine
  fi
  if [[ "$update_java" = "yes" ]]; then
    run_step "Installing Java runtime" extract_java
  fi

  echo
  echo "Dependencies updated successfully."
}

handle_existing_install() {
  local installed_wine installed_java update_wine="no" update_java="no"
  installed_wine="$(installed_source "$WINE_SOURCE_FILE")"
  installed_java="$(installed_source "$JAVA_SOURCE_FILE")"

  echo "Jagex Launcher is already installed."

  if source_changed "$WINE_URL" "$installed_wine"; then
    update_wine="yes"
  fi
  if source_changed "$JRE_URL" "$installed_java"; then
    update_java="yes"
  fi

  if [[ "$update_wine" = "yes" || "$update_java" = "yes" ]]; then
    if confirm "Dependency updates are available. Update now?"; then
      update_dependencies "$update_wine" "$update_java"
      exit 0
    fi
  fi

  if confirm "Uninstall Jagex Launcher?"; then
    uninstall
  fi
}
run_launcher() {
  ("$LAUNCHER_SCRIPT" >/dev/null 2>&1 &) || true
}

uninstall() {
  if [[ -d "$BASE_DIR" ]]; then
    rm -f "$DESKTOP_FILE"
    rm -rf "$BASE_DIR" "$STATE_DIR"
    echo "Jagex Launcher uninstalled successfully."
  else
    echo "The Jagex Launcher is not installed."
  fi
}

do_install() {
  if is_installed; then
    echo "The Jagex Launcher is already installed."
    return 0
  fi

  eula_gate
  INSTALLING=1
  create_dirs
  create_log

  download_files

  echo
  echo "Installing"
  run_step "Wine runtime" extract_wine
  run_step "Java runtime" extract_java
  run_step "Wine prefix" create_prefix
  run_step "Jagex Launcher files" install_launcher
  run_step "RuneLite client" install_runelite
  run_step "HDOS client" install_hdos
  run_step "Client integration" register_clients
  run_step "Desktop entry" install_shortcuts
  INSTALLING=0
  printf '\nInstallation completed successfully.\n'
  printf 'Starting the Jagex Launcher. After updating it can be launched from your application menu.\n\n'
  run_launcher
}

# Entry
require_cmd python3
require_cmd tar

case "$(uname -m)" in
  x86_64|amd64) ;;
  *) die "This installer currently supports x86_64 Linux only." ;;
esac

if is_installed; then
  handle_existing_install
  exit 0
fi

if [[ -d "$BASE_DIR" ]]; then
  echo "The Jagex Launcher did not install correctly."
  if confirm "Remove the installation?"; then
    uninstall
  fi
  exit 0
fi

do_install
