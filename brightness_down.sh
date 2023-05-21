#!/usr/bin/env bash
brightnessctl set $(echo "if ($(brightnessctl get) * 0.8 < 0) 0 else if ($(brightnessctl get) * 0.8 > ($(brightnessctl get)-1)) ($(brightnessctl get)-1) else $(brightnessctl get) * 0.8 " | bc | awk '{printf("%d\n",$1 + 0.5)}')
