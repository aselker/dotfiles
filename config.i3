# This file has been auto-generated by i3-config-wizard(1).
# It will not be overwritten, so edit it as you like.
#
# Should you change your keyboard layout some time, delete
# this file and re-run i3-config-wizard(1).
#

# i3 config file (v4)
#
# Please see https://i3wm.org/docs/userguide.html for a complete reference!

set $mod Mod4

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
#font pango:monospace 8
font pango:DejaVu Sans Mono 8

# Border settings.
# normal # -> has title bar and #-pixel border, pixel # -> just the border, none -> no border
#new_window pixel 1
#new_float pixel 1
new_window none
new_float none

# Hotkey to toggle borders
bindsym $mod+b border toggle

# Hide "unnecessary" borders on the outside of the screen
hide_edge_borders smart

# This font is widely installed, provides lots of unicode glyphs, right-to-left
# text rendering and scalability on retina/hidpi displays (thanks to pango).
font pango:DejaVu Sans Mono 8
#font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1

# Colors!
# class                 border  backgr. text    indicator child_border
#client.focused          #4c7899 #285577 #ffffff #2e9ef4   #285577
client.focused          #4c7899 #285577 #ffffff #2e9ef4   #285577
client.focused_inactive #333333 #5f676a #ffffff #484e50   #5f676a
client.unfocused        #333333 #222222 #888888 #292d2e   #222222
client.urgent           #2f343a #900000 #ffffff #900000   #900000
client.placeholder      #000000 #0c0c0c #ffffff #000000   #0c0c0c

client.background       #ffffff

# Before i3 v4.8, we used to recommend this one as the default:
# font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
# The font above is very space-efficient, that is, it looks good, sharp and
# clear in small sizes. However, its unicode glyph coverage is limited, the old
# X core fonts rendering does not support right-to-left and this being a bitmap
# font, it doesn’t scale on retina/hidpi displays.

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# start a terminal
bindsym $mod+Return exec i3-sensible-terminal

# start a file manager
bindsym $mod+o exec nautilus

# screen lock
bindsym $mod+m exec "killall -SIGUSR1 dunst; i3lock -i ~/Tech/lockscreen.png -n; killall -SIGUSR2 dunst"

# toggle the touchscreen
 bindsym --release $mod+t exec ~/.local/bin/toggletouchscreen.fish

# copy text with OCR
bindsym --release $mod+c exec ~/.local/bin/ocr_cp

bindsym --release $mod+x exec xkill

# volume and brightness control
#bindsym $mod+XF86Mute exec amixer set Master toggle
bindcode 121 exec amixer -D pulse set Master toggle
bindsym XF86AudioLowerVolume exec amixer -D pulse set Master 1%- unmute
bindsym Shift+XF86AudioLowerVolume exec amixer -D pulse set Master 6%- unmute
bindsym XF86AudioRaiseVolume exec amixer -D pulse set Master 1%+ unmute
bindsym Shift+XF86AudioRaiseVolume exec amixer -D pulse set Master 6%+ unmute
bindsym $mod+apostrophe exec amixer set Capture toggle

bindsym XF86MonBrightnessDown exec /home/neophile/.dotfiles/brightness_down.sh
bindsym XF86MonBrightnessUp exec brightnessctl set $(echo "if ($(brightnessctl get) < 4) ($(brightnessctl get) + 1) else $(brightnessctl get) * 1.20 + $(brightnessctl max) * 0.0015" | bc)
bindsym Shift+XF86MonBrightnessDown exec brightnessctl set 0
bindsym Shift+XF86MonBrightnessUp exec brightnessctl set $(brightnessctl max)

bindsym XF86Display exec sudo /usr/bin/thinkpad_turn_off_leds.sh
bindsym XF86Tools exec sudo /usr/bin/reload_psmouse.sh

bindsym --release XF86Favorites exec "sleep 1 && xset dpms force off"

# kill focused window
bindsym $mod+q kill

# 2020-03-04: Switched to _wrapper programs which are wrappers with these contents:

# #!/bin/bash
# 
# unset GTK_IM_MODULE
# unset QT_IM_MODULE
# unset XMODIFIERS
# dmenu_run , or i3-dmenu-desktop

# This is a workaround for https://bugs.archlinux.org/task/61673

# start dmenu (a program launcher) for all programs
bindsym $mod+Shift+p exec dmenu_run_wrapper
# There also is the (new) i3-dmenu-desktop which only displays applications
# shipping a .desktop file. It is a wrapper around dmenu, so you need that
# installed.
bindsym $mod+p exec --no-startup-id i3-dmenu-desktop_wrapper

# change focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+g split h

# split in vertical orientation
bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
bindsym $mod+d focus child

# move to parent container
bindsym $mod+Shift+a exec ~/.local/bin/i3_move_to_parent.sh

# switch to workspace
bindsym $mod+Prior workspace prev
bindsym $mod+Next workspace Next

# Bind workspaces to monitors
set $monitor_primary eDP
set $monitor_secondary DisplayPort-1
set $monitor_tertiary eDP

workspace 0 output $monitor_tertiary
workspace 2 output $monitor_primary
workspace 3 output $monitor_secondary
workspace 4 output $monitor_primary
workspace 5 output $monitor_secondary
workspace 6 output $monitor_primary
workspace 7 output $monitor_secondary
workspace 8 output $monitor_primary
workspace 9 output $monitor_secondary
workspace 10 output $monitor_primary
workspace 11 output $monitor_secondary
workspace 12 output $monitor_primary
workspace 13 output $monitor_tertiary
workspace 22 output $monitor_primary
workspace 23 output $monitor_secondary
workspace 24 output $monitor_primary
workspace 25 output $monitor_secondary
workspace 26 output $monitor_primary
workspace 27 output $monitor_secondary
workspace 28 output $monitor_primary
workspace 29 output $monitor_secondary
workspace 30 output $monitor_primary
workspace 31 output $monitor_secondary
workspace 32 output $monitor_primary
workspace 35 output $monitor_tertiary

# Normal workspace keys
bindsym $mod+grave workspace 0
bindsym $mod+1 workspace 1
bindsym $mod+2 workspace 2
bindsym $mod+3 workspace 3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace 10
bindsym $mod+minus workspace 11
bindsym $mod+equal workspace 12
bindsym $mod+BackSpace workspace 13
bindsym $mod+Escape workspace 20
bindsym $mod+F1 workspace 21
bindsym $mod+F2 workspace 22
bindsym $mod+F3 workspace 23
bindsym $mod+F4 workspace 24
bindsym $mod+F5 workspace 25
bindsym $mod+F6 workspace 26
bindsym $mod+F7 workspace 27
bindsym $mod+F8 workspace 28
bindsym $mod+F9 workspace 29
bindsym $mod+F10 workspace 30
bindsym $mod+F11 workspace 31
bindsym $mod+F12 workspace 32
bindsym $mod+Home workspace 33
bindsym $mod+End workspace 34
bindsym $mod+Insert workspace 35
bindsym $mod+Delete workspace 36

# move focused container to workspace
bindsym $mod+Shift+Prior move container to workspace prev
bindsym $mod+Shift+Next move container to workspace Next

bindsym $mod+Shift+grave move container to workspace 0
bindsym $mod+Shift+1 move container to workspace 1
bindsym $mod+Shift+2 move container to workspace 2
bindsym $mod+Shift+3 move container to workspace 3
bindsym $mod+Shift+4 move container to workspace 4
bindsym $mod+Shift+5 move container to workspace 5
bindsym $mod+Shift+6 move container to workspace 6
bindsym $mod+Shift+7 move container to workspace 7
bindsym $mod+Shift+8 move container to workspace 8
bindsym $mod+Shift+9 move container to workspace 9
bindsym $mod+Shift+0 move container to workspace 10
bindsym $mod+Shift+minus move container to workspace 11
bindsym $mod+Shift+equal move container to workspace 12
bindsym $mod+Shift+BackSpace move container to workspace 13
bindsym $mod+Shift+Escape move container to workspace 20
bindsym $mod+Shift+F1 move container to workspace 21
bindsym $mod+Shift+F2 move container to workspace 22
bindsym $mod+Shift+F3 move container to workspace 23
bindsym $mod+Shift+F4 move container to workspace 24
bindsym $mod+Shift+F5 move container to workspace 25
bindsym $mod+Shift+F6 move container to workspace 26
bindsym $mod+Shift+F7 move container to workspace 27
bindsym $mod+Shift+F8 move container to workspace 28
bindsym $mod+Shift+F9 move container to workspace 29
bindsym $mod+Shift+F10 move container to workspace 30
bindsym $mod+Shift+F11 move container to workspace 31
bindsym $mod+Shift+F12 move container to workspace 32
bindsym $mod+Shift+Home move container to workspace 33
bindsym $mod+Shift+End move container to workspace 34
bindsym $mod+Shift+Insert move container to workspace 35
bindsym $mod+Shift+Delete move container to workspace 36

bindsym $mod+Ctrl+grave exec i3_swap_workspaces.sh 0
bindsym $mod+Ctrl+1 exec i3_swap_workspaces.sh 1
bindsym $mod+Ctrl+2 exec i3_swap_workspaces.sh 2
bindsym $mod+Ctrl+3 exec i3_swap_workspaces.sh 3
bindsym $mod+Ctrl+4 exec i3_swap_workspaces.sh 4
bindsym $mod+Ctrl+5 exec i3_swap_workspaces.sh 5
bindsym $mod+Ctrl+6 exec i3_swap_workspaces.sh 6
bindsym $mod+Ctrl+7 exec i3_swap_workspaces.sh 7
bindsym $mod+Ctrl+8 exec i3_swap_workspaces.sh 8
bindsym $mod+Ctrl+9 exec i3_swap_workspaces.sh 9
bindsym $mod+Ctrl+0 exec i3_swap_workspaces.sh 10
bindsym $mod+Ctrl+minus exec i3_swap_workspaces.sh 11
bindsym $mod+Ctrl+equal exec i3_swap_workspaces.sh 12
bindsym $mod+Ctrl+BackSpace exec i3_swap_workspaces.sh 13
bindsym $mod+Ctrl+Escape exec i3_swap_workspaces.sh 20
bindsym $mod+Ctrl+F1 exec i3_swap_workspaces.sh 21
bindsym $mod+Ctrl+F2 exec i3_swap_workspaces.sh 22
bindsym $mod+Ctrl+F3 exec i3_swap_workspaces.sh 23
bindsym $mod+Ctrl+F4 exec i3_swap_workspaces.sh 24
bindsym $mod+Ctrl+F5 exec i3_swap_workspaces.sh 25
bindsym $mod+Ctrl+F6 exec i3_swap_workspaces.sh 26
bindsym $mod+Ctrl+F7 exec i3_swap_workspaces.sh 27
bindsym $mod+Ctrl+F8 exec i3_swap_workspaces.sh 28
bindsym $mod+Ctrl+F9 exec i3_swap_workspaces.sh 29
bindsym $mod+Ctrl+F10 exec i3_swap_workspaces.sh 30
bindsym $mod+Ctrl+F11 exec i3_swap_workspaces.sh 31
bindsym $mod+Ctrl+F12 exec i3_swap_workspaces.sh 32
bindsym $mod+Ctrl+Home exec i3_swap_workspaces.sh 33
bindsym $mod+Ctrl+End exec i3_swap_workspaces.sh 34
bindsym $mod+Ctrl+Insert exec i3_swap_workspaces.sh 35
bindsym $mod+Ctrl+Delete exec i3_swap_workspaces.sh 36

# Move windows to scratchpad, and show the scratchpad
bindsym $mod+n scratchpad show
bindsym $mod+Shift+n move scratchpad

# move workspace to other RandR output
# Right and up work for two monitors in arbitrary orientation 
bindsym $mod+bracketleft move workspace to output up
bindsym $mod+y move workspace to output left
bindsym $mod+bracketright move workspace to output down
bindsym $mod+u move workspace to output right
# bindsym $mod+bracketright exec ~/.config/i3/i3-display-swap.sh

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+q exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym h resize shrink width 5 px or 5 ppt
        bindsym j resize grow height 5 px or 5 ppt
        bindsym k resize shrink height 5 px or 5 ppt
        bindsym l resize grow width 5 px or 5 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 5 px or 5 ppt
        bindsym Down resize grow height 5 px or 5 ppt
        bindsym Up resize shrink height 5 px or 5 ppt
        bindsym Right resize grow width 5 px or 5 ppt

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"

# Disable mouse warping, because it triggers the bug where a mouse with non-identity transformation matrix
# jumps after warping.
#mouse_warping none

# Make some windows default to floating
# for_window [class="Matplotlib"] floating enable

# Default workspaces
assign [class="Signal"] 36

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
        # disable scrolling to change workspaces
        bindsym button4 nop
        bindsym button5 nop
        mode hide

        status_command ~/.config/i3/mem.sh
}

exec /bin/bash ~/.xinitrc #Run the xinitrc script, regardless of how i3 was started.
