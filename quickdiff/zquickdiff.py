#!/usr/bin/env python
import sys, subprocess

list = str(subprocess.Popen(['zcat', sys.argv[2]], stdout=subprocess.PIPE).communicate()).split('\\n')
list2 = str(subprocess.Popen(['zcat', sys.argv[1]], stdout=subprocess.PIPE).communicate()).split('\\n')
for line in list2:
        for match in list:
#		print match + " " + line
                if line in match: 
                        list.pop(list.index(match))
                        break
for line in list: print line.strip()
