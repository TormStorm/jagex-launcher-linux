#!/bin/sh
flatpak run --env=PULSE_LATENCY_MSEC=200 --env='vblank_mode=0' --env='MESA_GL_VERSION_OVERRIDE=4.5FC' com.jagex.RuneScape