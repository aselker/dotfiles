nm-applet & # Should this be in config.i3 instead?
compton --config ~/.dotfiles/compton.conf &
pkill -f "Wallpaper randomizer"; 
sleep 0.1; 

bash -c "while true; do feh --bg-fill --recursive --randomize ~/Media/Pictures/Wallpaper/*; sleep 1200; done # Wallpaper randomizer" &
pulseaudio --start &

export MOZ_USE_XINPUT2=1 # Firefox touch scrolling
