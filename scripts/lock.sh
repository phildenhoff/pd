#!/usr/bin/env bash
# Requires lock icong at "$HOME/.xlock/icon.png"

icon="$HOME/.xlock/icon.png"
tmpbg='/tmp/screen.png'
font='Noto-Sans-UI-Bold'
text='Enter password to log in.'

(( $# )) && { icon=$1; }

scrot "$tmpbg" -q 5
convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
convert "$tmpbg" -font "$font" -pointsize 64 -gravity center -fill "#eee" -stroke "#111" -strokewidth 2 -annotate +0+500 "$text" "$tmpbg"
convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
i3lock -i "$tmpbg"
