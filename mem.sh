#!/usr/bin/env sh

i3status | (read line && echo "$line" && read line && echo "$line" && read line && echo "$line" && while :
do
  read line
	# memory= awk '/MemTotal/ {memtotal=$2}; /MemAvailable/ {memavail=$2}; END { printf("%.0f", memavail / 1000) }' /proc/meminfo;
	echo ",[{\"full_text\":\"$(cpupower frequency-info -f | sed -n '2s/\([^0-9]\|.\{3\} \)//gp')\"},{\"full_text\":\"$(awk '/MemTotal/ {memtotal=$2}; /MemAvailable/ {memavail=$2}; END { printf("%.0f", memavail / 1000) }' /proc/meminfo)\"},${line#,\[}" || exit 1
done)
