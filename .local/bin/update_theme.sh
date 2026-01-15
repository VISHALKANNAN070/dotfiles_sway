#!/bin/bash

# --- 1. THEME CONFIGURATION (CHANGE THIS SECTION ONLY) ---

# Your Palette
BG="#212224"       # Background
FG="#ece1db"       # Foreground (Text)
SEC="#575a6d"      # Secondary/Selection/Black
ACC1="#828b9e"     # Blue-ish
ACC2="#c4a1b5"     # Pink-ish
ACC3="#94c8d8"     # Cyan-ish
ACC4="#c3cbac"     # Green-ish
ACC5="#ead3c7"     # Peach-ish

# ---------------------------------------------------------

echo "Applying theme..."

# --- 2. KITTY CONFIGURATION ---
# We create a file that Kitty will include
cat > ~/.config/kitty/theme.conf <<EOF
foreground            $FG
background            $BG
selection_foreground  $FG
selection_background  $SEC
url_color             $ACC3

# Black
color0  $BG
color8  $SEC

# Red
color1  $ACC2
color9  $ACC2

# Green
color2  $ACC4
color10 $ACC4

# Yellow
color3  $ACC5
color11 $ACC5

# Blue
color4  $ACC1
color12 $ACC1

# Magenta
color5  $ACC2
color13 $ACC2

# Cyan
color6  $ACC3
color14 $ACC3

# White
color7  $FG
color15 $FG
EOF

# Reload Kitty (Live update)
killall -SIGUSR1 kitty 2>/dev/null


# --- 3. WAYBAR CONFIGURATION ---
# We create a CSS file for Waybar to import
cat > ~/.config/waybar/colors.css <<EOF
@define-color background $BG;
@define-color foreground $FG;
@define-color secondary  $SEC;
@define-color accent1    $ACC1;
@define-color accent2    $ACC2;
@define-color accent3    $ACC3;
@define-color accent4    $ACC4;
@define-color accent5    $ACC5;
EOF

# Reload Waybar
killall -SIGUSR2 waybar 2>/dev/null


# --- 4. MICRO CONFIGURATION ---
# Micro needs a YAML-like theme file.
# Note: Micro doesn't support variables well, so we hardcode the hexes into the theme file.
cat > ~/.config/micro/colorschemes/dynamic.micro <<EOF
color-link default "$FG,$BG"
color-link comment "$SEC"
color-link identifier "$ACC3"
color-link constant "$ACC2"
color-link constant.string "$ACC4"
color-link statement "$ACC5"
color-link symbol "$ACC2"
color-link preproc "$ACC1"
color-link type "$ACC3"
color-link special "$ACC2"
color-link underlined "$ACC3"
color-link error "bold $ACC5"
color-link todo "bold $ACC1"
color-link statusline "$FG,$SEC"
color-link tabbar "$FG,$SEC"
color-link indent-char "$SEC"
color-link line-number "$SEC,$BG"
color-link current-line-number "$ACC5,$BG"
color-link gutter-error "$ACC5"
color-link gutter-warning "$ACC5"
color-link cursor-line "$SEC"
color-link color-column "$SEC"
EOF
# Micro does not support live reload for open instances. New instances will use this.


# --- 5. FUZZEL CONFIGURATION ---
# Fuzzel uses RRGGBBff format (needs alpha). We strip the # and add ff.

# Helper function to convert #RRGGBB to RRGGBBff
# --- 5. FUZZEL CONFIGURATION ---
# Helper function to convert #RRGGBB to RRGGBBff
to_fuzzel() {
    echo "${1:1}ff"
}

F_BG=$(to_fuzzel $BG)
F_FG=$(to_fuzzel $FG)
F_SEL=$(to_fuzzel $SEC)
F_ACC_MAIN=$(to_fuzzel $ACC3)  # Blue-ish for Apps
F_ACC_CLIP=$(to_fuzzel $ACC2)  # Pink-ish for Clipboard

# 1. Create the Main Theme (for apps.ini)
cat > ~/.config/fuzzel/apps.ini <<EOF
include=~/config/fuzzel/fuzzel-theme.ini
[main]
font=ZedMono Nerd Font:size=14
prompt="› "
icons-enabled=yes
lines=7
width=34
horizontal-pad=20
vertical-pad=12
inner-pad=10

[colors]
background=$F_BG
text=$F_FG
match=$F_ACC_MAIN
selection=$F_SEL
selection-text=$F_FG
border=$F_ACC_MAIN
EOF

# 2. Create the Clipboard Theme (for clip.ini)
cat > ~/.config/fuzzel/clip.ini <<EOF
include=~/config/fuzzel/fuzzel-theme.ini

[main]
font=ZedMono Nerd Font:size=10
prompt="> "
icons-enabled=no

lines=5
width=190

horizontal-pad=0
vertical-pad=0
inner-pad=10
item-padding=10
line-height=20

anchor=bottom
x-margin=0
y-margin=0

[colors]
background=$F_BG
text=$F_FG
match=$F_ACC_CLIP
selection=$F_SEL
selection-text=$F_FG
border=$F_ACC_CLIP
EOF

echo "Theme applied successfully!"
