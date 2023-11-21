#!/usr/bin/env bash
while true; do swaymsg output "*" bg "`(find ~/Media/Pictures/Wallpaper/ -type f | shuf -n 1 | sed 's/(/\\\\(/' | sed 's/)/\\\\)/')`" fill; sleep 2400; done
