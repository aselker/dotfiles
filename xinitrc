xrandr --output DP-0 --mode 3840x2160 --rotate normal --pos 0x0 --output HDMI-0 --mode 1920x1080 --rotate normal --scale 1.5x1.5 --pos 3840x0 # 980 desktop, two monitors, both horizontal, smaller one on the right

nm-applet &
compton --config ~/.dotfiles/compton.conf &
pkill -f "Wallpaper randomizer"; 
sleep 0.1; 

bash -c "while true; do feh --bg-fill --recursive --randomize ~/Media/Pictures/Wallpaper/*; sleep 1200; done # Wallpaper randomizer" &
