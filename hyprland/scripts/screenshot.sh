#!/bin/sh
region=$(slurp) || exit 0
grim -g "$region" - | tee ~/Pictures/Screenshots/screenshot_$(date +%Y%m%d_%H%M%S).png | wl-copy
pw-play /usr/share/sounds/freedesktop/stereo/camera-shutter.oga
