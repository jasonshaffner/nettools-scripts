#!/bin/bash

mkdir ~/.nettools
cd ../src/
for s in $( ls ); do
	echo "alias $s=~/.nettools/.$s" >> ~/.bashrc
	cp $s ~/.nettools/.$s
	chmod +x ~/.nettools/.$s
done
echo Installed. Please run "source ~/.bashrc" to complete.
