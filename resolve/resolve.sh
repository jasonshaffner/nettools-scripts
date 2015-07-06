#!/bin/bash

function dnsresolve() {
	if [ -z "$2" ] || [ "$1" == "-f" ]; then
	        noflags=true
	elif [[ "$1" =~ \-.*c.* ]]; then
	        complete=true
	elif [[ "$1" =~ \-.*n.* ]]; then
	        complete=false
	fi
	if [[ "$1" =~ \-.*r.* ]]; then
	        reverse=true
	fi
	if [[ "$1" =~ \-.*i.* ]]; then
	        iponly=true
	fi
	if [[ "$1" =~ \-.*d.* ]]; then
		comma=true
	fi
	if [ -z "$2" ]; then
		HOSTNAME=$1
	else
		HOSTNAME=$2
	fi
	output="$( host $HOSTNAME | head -n 1 )"
	if [[ ! "$output" =~ "not found" ]]; then
		hostname="$( echo -e "$output" | sed 's/\s.*//' )"
		ip="$( echo -e "$output" | sed 's/.*address //' )"
                if [ ! $reverse ] && [ ! $iponly ]; then
			if [ $comma ]; then
                        	printf '%s,%s\n' $ip $hostname
			else
                        	printf '%-12s\t %-30s\n' $ip $hostname
			fi	
                elif [ $iponly ]; then
                        echo -e "$ip"
                else
			if [ $comma ]; then
                        	printf '%s,%s\n' $hostname $ip
			else
                        	printf '%-12s\t %-30s\n' $hostname $ip
			fi	
                fi
        elif [ $noflags ]; then
		exit 0
        elif [ $complete ] && [ $complete == true ]; then
                if [ ! $reverse ] && [ ! $iponly ]; then
			if [ $comma ]; then
                        	printf '%s,%s\n' "" $HOSTNAME
			else
                        	printf '%-12s\t %-30s\n' "" $HOSTNAME
			fi
                elif [ $iponly ]; then
                        echo -e ""
                else
			if [ $comma ]; then
                        	printf '%s,%s\n' "$HOSTNAME" ","
			else
				echo -e "$HOSTNAME"
			fi	
                fi
        elif [ $complete ]; then
                if [ ! $reverse ] && [ ! $iponly ]; then
			if [ $comma ]; then
                        	printf '%s,%s\n' "No IP Found" $HOSTNAME
			else
                        	printf '%-12s\t %-30s\n' "No IP Found" $HOSTNAME
			fi	
                elif [ $iponly ]; then
                        echo -e "No IP Found"
                else
			if [ $comma ]; then
				printf '%s,%s\n' $HOSTNAME "No IP Found"
			else
                        	printf '%-30s\t %-12s\n' $HOSTNAME "No IP Found" 
			fi
                fi
        fi
}
(if [ -z "$1" ] || [ "-h" == "$1" ] || [ "--help" == "$1" ] || ( [ ! -f "${@: -1}" ] && [[ "$1" =~ \-.*f.* ]] ); then
        exit 3
elif [[ "$1" =~ \-.*f.* ]]; then
	while read HOSTNAME; do
		dnsresolve "$1" "$HOSTNAME"
	done < "$2"
else
	dnsresolve "$@"
fi)
if [ $? = 3 ]; then
        printf "\nUsage:\t\tresolve [OPTION] [filename] | [hostname]\n"
        printf  "Example:\tresolve -f hostnames.txt\n\n"
        printf  "Input file should include hostname per line\n\n"
        printf  "Options:\n"
        printf  "\t-h\tPrints this help message\n"
        printf  "\t-c\tPrints hostnames regardless of whether DNS entry exists\n"
        printf  "\t-n\tLike -c, except prints \"No IP Found\" in the ip column\n"
	printf	"\t-d\tPrints comma separated results\n"
        printf  "\t-r\tPrints Hostnames in first column, IPs in second\n"
        printf  "\t-i\tPrints IPs only\n"
        printf  "\t-f\tAllows reading of hostnames from file\n\n"
fi
