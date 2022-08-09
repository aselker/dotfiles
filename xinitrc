xrandr --output DP-0 --mode 3840x2160 --rotate normal --pos 0x0 --output HDMI-0 --mode 1920x1080 --rotate normal --scale 1.5x1.5 --pos 3840x0 # 980 desktop, two monitors, both horizontal, smaller one on the right

nm-applet &
#compton --backend glx --unredir-if-possible --glx-no-stencil --glx-no-rebind-pixmap --glx-swap-method buffer-age --vsync opengl-swc &
#compton --backend glx --vsync opengl-swc & 
compton --config ~/.dotfiles/compton.conf &
#killall -q xcape; 
#killall -q redshift-gtk; 
pkill -f "Wallpaper randomizer"; 
sleep 0.1; 

# xcape -e "Control_L=Escape" &
#redshift-gtk &
bash -c "while true; do feh --bg-fill --recursive --randomize ~/Media/Pictures/Wallpaper/*; sleep 1200; done # Wallpaper randomizer" &

export MOZ_USE_XINPUT2=1 # Firefox touch scrolling
