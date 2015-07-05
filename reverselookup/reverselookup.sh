#!/bin/bash

(if [ -z "$1" ] || [ "-h" == "$1" ] || [ "--help" == "$1" ] || ( [ ! -f "${@: -1}" ] && [[ ! "$1" =~ \-.*i.* ]] ); then
	exit 3
elif [ -z "$2" ]; then
	noflags=true
elif [[ "$1" =~ \-.*c.* ]]; then
	complete=true
elif [[ "$1" =~ \-.*n.* ]]; then
	complete=false
fi
if [[ "$1" =~ \-.*r.* ]]; then
	reverse=true
fi
if [[ "$1" =~ \-.*H.* ]]; then
	hostonly=true
fi
if [[ "$1" =~ \-.*i.* ]]; then
	> .tmp
	if [[ ! "${@: -2:1}" =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]] || [[ ! "${@: -1}" =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
	        echo -e "Invalid IP address"
	        exit 3
	fi
	lowip="${@: -2:1}"
	highip="${@: -1}"
	low=(`echo $lowip | awk '{split($lowip,a,"."); print a[1]" "a[2]" "a[3]" "a[4]}'`)
	high=(`echo $highip | awk '{split($highip,a,"."); print a[1]" "a[2]" "a[3]" "a[4]}'`)
	max=255
	finished=false

	until [ $finished = true ]; do
	        if [ ${low[0]} -eq ${high[0]} ] && [ ${low[1]} -eq ${high[1]} ] && [ ${low[2]} -eq ${high[2]} ]; then
	                max=${high[3]}
	        fi
	
	        while [ ${low[3]} -le $max ];
	        do
	                printf "${low[0]}.${low[1]}.${low[2]}.${low[3]}\n" >> .tmp
	                if [ ${low[0]} -eq ${high[0]} ] && [ ${low[1]} -eq ${high[1]} ] && [ ${low[2]} -eq ${high[2]} ] && [ ${low[3]} -eq ${high[3]} ]; then
	                        finished=true
	                fi
	                low[3]=$(( ${low[3]} + 1 ))
	        done

	        low[2]=$(( ${low[2]} + 1 ))
	        low[3]=0
	
	        if [ ${low[2]} -gt $max ]; then
	                low[1]=$(( ${low[1]} + 1 ))
	                low[2]=0
	        fi
	
	        if [ ${low[1]} -gt $max ]; then
	                low[0]=$(( ${low[0]} + 1 ))
	                low[1]=0
	        fi
	
	        if [ ${low[0]} -gt $max ]; then
	                finished=true
	        fi
	done
	input=.tmp
else
	input="${@: -1}"
fi
while read ip; do
	if [[ ! "$ip" =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
		echo here
		exit 3 
	fi
	hostname=$( host $ip | tail -n 1 | sed -e 's/.*pointer //' -e 's/\.$//' ) 
        test -z "$hostname" && hostname="Error"
	if [[ $hostname != *"not found"* ]]; then 
		if [ ! $reverse ] && [ ! $hostonly ]; then
        		printf '%-12s\t %-30s\n' $ip $hostname
		elif [ $hostonly ]; then
			echo -e "$hostname"
		else
			printf '%-30s\t %-12s\n' $hostname $ip
		fi
	elif [ $noflags ]; then
		continue
	elif [ $complete ] && [ $complete == true ]; then
		if [ ! $reverse ] && [ ! $hostonly ]; then
			echo -e "$ip"
		elif [ $hostonly ]; then
			echo -e ""
		else
			printf '%-30s\t %-12s\n' "" $ip
		fi
	elif [ $complete ]; then
		if [ ! $reverse ] && [ ! $hostonly ]; then
			printf '%-12s\t %-30s\n' $ip "No DNS Entry Found"
		elif [ $hostonly ]; then
			echo -e "No DNS Entry Found"
		else
			printf '%-30s\t %-12s\n' "No DNS Entry Found" $ip
		fi
	fi
done < $input
if [[ "$1" =~ \-.*i.* ]]; then
	rm .tmp
fi)
if [ $? = 3 ]
then
	printf "\nUsage:\t\treverselookup [OPTION] [filename] | [start ip address] [end ip address]\n"
	printf	"Example:\treverselookup -c ipaddresses.txt\n\n"
	printf	"Input file should include one ip address per line\n\n"
	printf	"Options:\n"
	printf	"\t-h\tPrints this help message\n"
	printf	"\t-c\tPrints IPs regardless of whether DNS entry exists\n"
	printf	"\t-n\tLike -c, except prints \"No DNS Entry Found\" in the hostname column\n"
	printf	"\t-r\tPrints Hostnames in first column, IPs in second\n"
	printf	"\t-H\tPrints Hostnames only\n"
	printf	"\t-i\tAllows use of start and end IP addresses for range lookups\n\n"
	if [ -f .tmp ]; then
		rm .tmp
	fi
fi
