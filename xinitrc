#setxkbmap -option ctrl:nocaps & # Disabled because should be set in xorg.conf.d
nm-applet &
compton &
#killall -q xcape; 
killall -q redshift-gtk; 
pkill -f "Wallpaper randomizer"; 
sleep 0.1; 

# xcape -e "Control_L=Escape" &
redshift-gtk &
bash -c "while true; do feh --bg-fill --recursive --randomize ~/Media/Pictures/Wallpaper/*; sleep 1200; done # Wallpaper randomizer" &

export MOZ_USE_XINPUT2=1 # Firefox touch scrolling
