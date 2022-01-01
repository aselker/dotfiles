nm-applet &
picom &
#killall -q xcape; 
killall -q redshift;
pkill -f "Wallpaper randomizer"; 
sleep 0.1; 

# xcape -e "Control_L=Escape" &
redshift -l 37.8271784:-122.2913078 &
bash -c "while true; do feh --bg-fill --recursive --randomize ~/Media/Pictures/Wallpaper/*; sleep 1200; done # Wallpaper randomizer" &

export MOZ_USE_XINPUT2=1 # Firefox touch scrolling
