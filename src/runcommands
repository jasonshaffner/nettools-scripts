#!/usr/bin/env python

import getpass, telnetlib, os, re, time, threading

username = raw_input("Username: ")
password = getpass.getpass()
devicelist = raw_input("Device list file: ")
hostnames = open(devicelist, 'r')
report = []
dontprint = ['show', 'term', 'screen-length', 'Screen length', '{master', 'Building config', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
junoscommands = list(open('JUNOS', 'r'))
ioscommands = list(open('IOS', 'r'))
xrcommands = list(open('XR', 'r'))

class login (threading.Thread):
	def __init__(self, hostname):
		threading.Thread.__init__(self)
		self.hostname = hostname
	def run(self):
		work(self.hostname)

def work(hostname):
        host = hostname.split('.', 1)[0]
        try:
                session = telnetlib.Telnet(hostname,23,3)
                session.expect(['sername:','ogin'],5)
                session.write(username + '\r')
                session.read_until('assword:')
                session.write(password + '\r')
                software, match, previous_text = session.expect(['CPU0:' + host + '#', host + '#', username + '@' + host + '>'], 3)
		dontprint.append(previous_text.split('\n')[-1].strip())
        except:
                temp = list(["\nCould not log in to " + host, ])
                report.append(temp)
		return
        if software == 0:
                commands = xrcommands
                commands.insert(0, 'term len 0')
        elif software == 1:
                commands = ioscommands
                commands.insert(0, 'term len 0')
        else:
                commands = junoscommands
                commands.insert(0, 'set cli screen-length 0')
        temp = list(['\n\n*************** ' + host + ' ***************\n\n', ])
	flag = 0
        for line in commands:
                session.write(line.strip() + '\r')
                time.sleep(5)
		if flag == 0:
			flag = 1
			continue
		temp.append(line + '_________________________________________\n')
                output = session.read_very_eager().split('\n')
                for l in output:
                        if any(n in l for n in dontprint): continue
			else: temp.append(l.strip())
		temp.append('\n\n')
        session.write('exit\r')
        session.close()
	report.append(temp)

threads = []
for line in hostnames:
        router = line.strip('\n')
	thread = login(router)
	threads.append(thread)
	thread.start()
for t in threads:
	t.join()
hostnames.close()
report = sorted(report, key=lambda hostname: hostname[0])
for y in report: 
	for x in y: print x
