#!/usr/bin/env python
import sys

list = open(sys.argv[2], 'r').readlines()
list2 = open(sys.argv[1], 'r').readlines()
for line in list2:
	for match in list:
		if line in match: 
			list.pop(list.index(match))
			break
for line in list: 
	line = line.strip()
	if not line: continue
	print line
