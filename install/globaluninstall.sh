#!/bin/bash

cd ../src/
dir="$( echo $PATH | tr ":" "\n" | head -n 1 )"
for s in $( ls ); do
	rm "$dir"/"$s"
done
