#!/usr/bin/env bash 
cur_ws=$(swaymsg -t get_workspaces | jq -r '.[]|select(.focused)|.name')
inp=$1

other_ws=$inp

if [[ "$cur_ws" != "$other_ws" ]]
then
  swaymsg "rename workspace $cur_ws to tmp"
  swaymsg "rename workspace $other_ws to $cur_ws"
  swaymsg "rename workspace tmp to $other_ws"
fi
