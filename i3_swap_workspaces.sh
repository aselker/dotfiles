#!/usr/bin/env bash 
cur_ws=$(i3-msg -t get_workspaces | grep -e '"name":"[0-9]\+","visible":true,"focused":true' -o | cut -d '"' -f 4)
#inp=$(i3-input -P "new name" | grep -e "command = .*\$" -o)
inp=$1

case $inp in
  1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9)
    other_ws=$inp
    ;;
  grave)
    other_ws=0
    ;;
  minus) 
    other_ws=11
    ;;
  equal) 
    other_ws=12
    ;;
  BackSpace) 
    other_ws=13
    ;;
  Escape) 
    other_ws=20
    ;;
  F1) 
    other_ws=21
    ;;
  F2) 
    other_ws=22
    ;;
  F3) 
    other_ws=23
    ;;
  F4) 
    other_ws=24
    ;;
  F5) 
    other_ws=25
    ;;
  F6) 
    other_ws=26
    ;;
  F7) 
    other_ws=27
    ;;
  F8) 
    other_ws=28
    ;;
  F9) 
    other_ws=29
    ;;
  F10) 
    other_ws=30
    ;;
  F11) 
    other_ws=31
    ;;
  F12) 
    other_ws=32
    ;;
  Print) 
    other_ws=33
    ;;
  Insert) 
    other_ws=34
    ;;
  Delete) 
    other_ws=35
    ;;
esac

#echo $cur_ws
#echo $other_ws
i3-msg "rename workspace $cur_ws to tmp"
i3-msg "rename workspace $other_ws to $cur_ws"
i3-msg "rename workspace tmp to $other_ws"
