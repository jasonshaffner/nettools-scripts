#!/bin/bash

function convert() {
	if [[ "$1" =~ \-.*m.* ]]; then
		if [ -z "$3" ]; then
			printf '%s %s' "$(printf "$2" | sed 's/\/.*//')" "$(/usr/bin/ipcalc -b "$2" | grep mask | sed 's/^.*:\s*\(.*\)\s*=.*/\1/')"
		else
			printf '%s %s' "$2" "$(/usr/bin/ipcalc -b "$2" "$3" | grep mask | sed 's/.*:\s*\(.*\)\s*=.*/\1/')"
		fi
	elif [[ "$1" =~ \-.*c.* ]]; then
		if [ -z "$3" ]; then
			printf '%s%s ' "$(echo "$2" | sed 's/\/.*//')" "$(/usr/bin/ipcalc -b "$2" | grep -i mask | sed 's/.*=\s*\([0-9]*\).*/\/\1/')"
		else
			printf '%s%s ' "$2" "$(/usr/bin/ipcalc -b "$2" "$3" | grep -i mask | sed 's/.*=\s*\([0-9]*\).*/\/\1/')"
		fi
	elif [[ "$1" =~ \-.*w.* ]]; then
		if [ -z "$3" ]; then
			printf '%s %s ' "$(echo "$2" | sed 's/\/.*//')" "$(/usr/bin/ipcalc -b "$2" | grep Wild | sed 's/.*:\s*\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\).*/\1/')"
		else
			printf '%s %s ' "$2" "$(/usr/bin/ipcalc -b "$2" "$3" | grep Wild | sed 's/.*:\s*\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\).*/\1/')"
		fi
	fi
	if [[ ! "$1" =~ \-.*f.* ]]; then
		printf "\n"
	fi
}

(if [ -z "$1" ] || [ "-h" == "$1" ] || [ "--help" == "$1" ]; then
        exit 3
fi
if [[ "$1" =~ \-.*f.* ]]; then
	input="$2"
	while read line; do
		if [[ ! "$line" =~ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\/?[0-9]? ]]; then
			echo "$line"
			continue
		fi
		lines=($line)
		for (( i=0;i < ${#lines[@]}; i++)); do
			if [[ "${lines[$i]}" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\/?[0-9]? ]]; then
				if [[ "${lines[$i]}" =~ / ]]; then
					convert "$1" "${lines[$i]}"
				elif [ -z $ip ]; then
					if [[ $i -eq ${#lines[@]}-1 ]]; then
						printf '%s ' "${lines[$i]}"
					else
						ip=${lines[$i]}
					fi
				else
					convert "$1" "$ip" "${lines[$i]}"
					ip=
				fi
			elif [ ! -z $ip ]; then
				printf '%s %s ' "$ip" "${lines[$i]}" # | sed -e 's/\([\/*?$]\)/\\\1/g'
				ip=
			elif [ ! -z "${lines[$i]}" ]; then
				printf '%s ' "${lines[i]}" # | sed -e 's/\([\/*?$]\)/\\\1/g'
			fi		
		done
		printf '%s \n'
	done < $input
else
	convert "$@"
fi)
if [ $? = 3 ]; then
        printf "\nUsage:\t\tconvertmask [OPTION] [filename] | [ip address] [subnet mask] | [ip address/cidr]\n"
        printf  "Example:\tconvertmask -c 8.8.8.8 255.255.255.252\n\n"
        printf  "Options:\n"
        printf  "\t-h\tPrints this help message\n"
        printf  "\t-c\tConverts subnet mask or wildcard to cidr notation\n"
        printf  "\t-m\tConverts cidr notation or wildcard to subnet mask \n"
        printf  "\t-m\tConverts subnet mask or cidr notation to wildcard\n"
	printf	"\t-f\tAllows reading and conversion of file\n\n"
fi
