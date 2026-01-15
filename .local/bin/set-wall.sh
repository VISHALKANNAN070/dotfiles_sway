#!/usr/bin/env bash

WALLDIR="$HOME/Pictures/wallpapers"
CACHE_DIR="$HOME/.cache/wall-thumbs"
mkdir -p "$CACHE_DIR"

# Check if imagemagick is installed
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick is not installed. Please install it first."
    exit 1
fi

# Generate list and pipe DIRECTLY into Rofi
# We do not store this in a variable to avoid the "null byte" warning
FILE=$(
for img in "$WALLDIR"/*; do
    [ -f "$img" ] || continue
    fname=$(basename "$img")
    thumb="$CACHE_DIR/$fname"
    
    # Create thumb if missing (resize to 300x300 for speed)
    if [ ! -f "$thumb" ]; then
        convert "$img" -thumbnail 300x300 "$thumb"
    fi
    
    # Output format: Name \0 icon \x1f PathToThumb
    printf "%s\0icon\x1f%s\n" "$fname" "$thumb"
done | rofi -dmenu -i -show-icons \
    -p "Wallpaper" \
    -theme-str 'window { width: 60%; height: 50%; padding: 12px; }' \
    -theme-str 'mainbox { padding: 0px; }' \
    -theme-str 'listview { lines: 2; columns: 5; spacing: 12px; padding: 0px; }' \
    -theme-str 'element { orientation: vertical; padding: 8px; }' \
    -theme-str 'element normal { background-color: transparent; }' \
    -theme-str 'element alternate { background-color: transparent; }' \
    -theme-str 'element selected { background-color: rgba(255,255,255,0.06); }' \
    -theme-str 'element-icon { size: 180px; border-radius: 0px; }' \
    -theme-str 'element-text { padding-top: 6px; font: "ZedMono Nerd Font 10"; horizontal-align: 0.5; }'
        
       
)

[ -z "$FILE" ] && exit 0

WALLPAPER="$WALLDIR/$FILE"

# --- Apply Wallpaper & Colors ---
swww img "$WALLPAPER" --transition-type wipe --transition-pos top --transition-duration 0.6
wallust run -d "$HOME/.config/wallust" "$WALLPAPER"
~/.local/bin/wallust-waybar-contrast.sh
pkill -SIGUSR2 waybar
kitty @ set-colors -a "$HOME/.config/kitty/colors.conf" 2>/dev/null
