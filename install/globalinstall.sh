#!/bin/bash
cd ../src/
dir="$( echo $PATH | tr ":" "\n" | tail -n 1 )"
for s in $( ls ); do
	cp "%s" "$dir"
done
