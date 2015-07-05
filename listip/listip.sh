#!/bin/bash

( if [[ "$1" =~ \-.*h.* ]]; then
	exit 3
fi
if [[ ! ${@: -1} =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]] \
	|| [[ ! ${@: -2:1} =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
	echo -e "Invalid IP address"
	exit 3
fi
lowip=${@: -2:1}
highip=${@: -1}
low=(`echo "$lowip" | awk '{split($lowip,a,"."); print a[1]" "a[2]" "a[3]" "a[4]}'`)
high=(`echo "$highip" | awk '{split($highip,a,"."); print a[1]" "a[2]" "a[3]" "a[4]}'`)
max=255
finished=false

until [ $finished = true ];
do
        if [ ${low[0]} -eq ${high[0]} ] && [ ${low[1]} -eq ${high[1]} ] && [ ${low[2]} -eq ${high[2]} ]; then
                max=${high[3]}
        fi

        while [ ${low[3]} -le $max ];
        do
                printf "${low[0]}.${low[1]}.${low[2]}.${low[3]}\n"
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
done) 
if [ $? -eq 3 ]; then
	printf '\n%-10s %-25s\n' "Usage:" "listip startip endip"
	printf '%-10s %-25s\n\n' "Example:" "listip 10.0.0.0 10.0.0.10"
fi
exit 0
