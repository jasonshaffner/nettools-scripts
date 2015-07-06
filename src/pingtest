#!/bin/bash

function pingtester() {
	printf "$1"
        live="$(ping -c 3 -l 3 -W 1 "$1" | tail -n 2 | grep received | sed -e 's/.*transmitted, \([0-3]\).*/\1/')"
	if [[ "$live" > 0 ]]; then
		printf " UP\n"
	else
		printf " DOWN\n"
	fi
}

if [ -z "$2" ]; then
	while read IP; do
		pingtester "$IP"
	done < "$1"
else
	for IP in $( listip "$1" "$2" ); do
		pingtester "$IP"
	done
fi
