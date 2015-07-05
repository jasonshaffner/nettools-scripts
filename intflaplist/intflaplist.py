#!/usr/bin/env python

import getpass, telnetlib, time, re, sys

username = raw_input("Username: ")
password = getpass.getpass()
hostname = raw_input("Device: ")
host = hostname.split('.', 1)[0]
hour = raw_input('Time (24 hour clock): ')
if re.search('\:', hour): hour = "\:".join(hour.split(':'))
interface = ('GigE', 'ge-', 'te-', 'Te', 'Gi', 'Fa', 'ae', 'agg')
dontprint = ['show', 'set', '{master', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
month = time.strftime('%b')
day = time.strftime('%d')
if int(day) < 10: day = month + "  " + day[-1]
else: day = month + " " + day
if hour: day = day + ' ' + hour
day = day.strip()
try:
        session = telnetlib.Telnet(hostname,23,3)
        session.expect(['sername:','ogin'],5)
        session.write(username + '\r')
        session.read_until('assword:')
        session.write(password + '\r')
        software, match, previous_text = session.expect(['CPU0:' + host + '#', host + '#', username + '@' + host + '>'], 3)
        dontprint.append(previous_text.split('\n')[-1].strip())
except: 
	print 'Could not log in to ' + host
	sys.exit()
session.write('term len 0\r')
session.write('sh log | utility egrep -e \'' + day + '.*LINK-3-UPDOWN.*Down\'\r')
time.sleep(2)
output = session.read_very_eager().split('\n')
newlist = []
report = []
for line in output: newlist.append(line.split(' '))
for line in newlist: 
	for l in line:
		if any(i in l for i in interface): report.append(l.strip(','))
sortedlist = sorted(report, reverse=False)
dup = set()
report = []
for y in sortedlist:
	if y in dup: continue
	count = 0
	for f in sortedlist: 
		if f == y: count += 1
	report.append((y, count))
	dup.add(y)
session.write('sh int desc | ex admin\r')
time.sleep(5)
output = session.read_very_eager().split('\n')
print '\n\nFLAPS  INTERFACE          ADMIN       OPER        DESCRIPTION'
print '--------------------------------------------------------------------------------------'
for line in output:
	if any(n in line for n in dontprint): continue
	li = line.split(' ')
	l = li[0][2:]
	for lin in report:
		intnum = lin[0].split('E')[-1]
		if re.search(intnum, l) and re.search(li[0][:1], lin[0]):
			if lin[1] < 10: print '    ' + str(lin[1]) + '  ' + line
			elif lin[1] < 100: print '   ' + str(lin[1]) + '  ' + line
			elif lin[1] < 1000: print '  ' + str(lin[1]) + '  ' + line
			elif lin[1] < 10000: print ' ' + str(lin[1]) + '  ' + line
			else: print str(lin[1]) + ' ' + line
			report.pop(report.index(lin))
			break
