#!/bin/sh

CHOICE="$(printf "Lock\nLogout\nReboot\nShutdown" | \
fuzzel --dmenu --config ~/.config/fuzzel/apps.ini --prompt="Session: ")"

case "$CHOICE" in
  Lock)
    swaylock -f
    ;;
  Logout)
    swaymsg exit
    ;;
  Reboot)
    systemctl reboot
    ;;
  Shutdown)
    systemctl poweroff
    ;;
  *)
    exit 0
    ;;
esac
