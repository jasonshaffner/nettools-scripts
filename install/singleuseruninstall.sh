#!/bin/bash

rm -rf ~/.nettools
cd ../src/
for s in $( ls ); do
	sed '/nettools\/\.'$s'/d' ~/.bashrc > .tmp
	cp .tmp ~/.bashrc
done
rm .tmp
echo Uninstalled. Please run "source ~/.bashrc" to complete.
