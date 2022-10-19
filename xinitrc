nm-applet &
picom &
#killall -q xcape; 
pkill -f "Wallpaper randomizer"; 
sleep 0.1; 

# xcape -e "Control_L=Escape" &
bash -c "while true; do feh --bg-fill --recursive --randomize ~/Media/Pictures/Wallpaper/*; sleep 1200; done # Wallpaper randomizer" &

export MOZ_USE_XINPUT2=1 # Firefox touch scrolling
