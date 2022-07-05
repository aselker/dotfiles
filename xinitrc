nm-applet &
compton --config ~/.dotfiles/compton.conf &
#killall -q xcape; 
#killall -q redshift-gtk; 
pkill -f "Wallpaper randomizer"; 
sleep 0.1; 

# xcape -e "Control_L=Escape" &
#redshift-gtk &
bash -c "while true; do feh --bg-fill --recursive --randomize ~/Media/Pictures/Wallpaper/*; sleep 1200; done # Wallpaper randomizer" &
pulseaudio --start &

export MOZ_USE_XINPUT2=1 # Firefox touch scrolling
