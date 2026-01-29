#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Usage: theme-generator.sh /path/to/wallpaper"
    exit 1
fi

# Run matugen
matugen image "$1" -m dark -t scheme-content

# 1. Reload Waybar
pkill -USR2 waybar

# 2. Live reload ALL Kitty instances
# SIGUSR1 tells all kitty processes to reload their config file
killall -USR1 kitty
makoctl reload
nvim --server /tmp/nvim-matugen --remote-send '<cmd>lua ReloadMatugen()<CR>'

