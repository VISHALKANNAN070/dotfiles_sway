#!/bin/bash

# 1. Check power status
on_battery=$(cat /sys/class/power_supply/BAT0/status)

# 2. Define media player
MEDIA_PLAYER="mpv"

if [ "$on_battery" = "Discharging" ]; then
    # Pause music
    pkill -SIGSTOP $MEDIA_PLAYER
    
    # Lock screen (Corrected syntax)
    swaylock -f -c 000000
    
    # Turn off displays
    swaymsg "output * power off"
else
    # Just lock screen (Corrected syntax)
    swaylock -f -c 000000
fi

# 3. EXIT HERE so this script doesn't try to run swayidle again
exit 0
