#!/bin/sh
set -e
flatpak run --env=PULSE_LATENCY_MSEC=200 \
    --env='vblank_mode=0' \
    --env='MESA_GL_VERSION_OVERRIDE=4.5FC' \
    --env='__NV_PRIME_RENDER_OFFLOAD=1' \
    --env='__GLX_VENDOR_LIBRARY_NAME=nvidia' \
    com.jagex.RuneScape || \
flatpak-spawn --host flatpak run \
    --env=PULSE_LATENCY_MSEC=200 \
    --env='vblank_mode=0' \
    --env='MESA_GL_VERSION_OVERRIDE=4.5FC' \
    --env=JX_ACCESS_TOKEN="$JX_ACCESS_TOKEN" \
    --env=JX_CHARACTER_ID="$JX_CHARACTER_ID" \
    --env=JX_DISPLAY_NAME="$JX_DISPLAY_NAME" \
    --env=JX_REFRESH_TOKEN="$JX_REFRESH_TOKEN" \
    --env=JX_SESSION_ID="$JX_SESSION_ID" \
    --env='__NV_PRIME_RENDER_OFFLOAD=1' \
    --env='__GLX_VENDOR_LIBRARY_NAME=nvidia' \
    com.jagex.RuneScape
