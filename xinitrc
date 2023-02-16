nm-applet &
picom &
#killall -q xcape; 
pkill -f "Wallpaper randomizer"; 
sleep 0.1; 

# xcape -e "Control_L=Escape" &
bash -c "while true; do feh --bg-fill --recursive --randomize ~/Media/Pictures/Wallpaper/*; sleep 1200; done # Wallpaper randomizer" &
systemctl --user start pulseaudio.service;
#bash -c "sleep 60 && systemctl --user start syncthing.service" &
export MOZ_USE_XINPUT2=1; # Firefox smoother scrolling?
xkbcomp /home/neophile/.dotfiles/hjkl.xkb $DISPLAY; # Set keymap
signal-desktop &
