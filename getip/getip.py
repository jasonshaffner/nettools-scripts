#!/usr/bin/env python

import getpass, telnetlib, os, re, time, threading

username = raw_input("Username: ")
password = getpass.getpass()
devicelist = raw_input("Device list file: ")
hostnames = open(devicelist, 'r')
report = []
dontprint = ['show', 'term', 'screen-length','{master', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']

class login (threading.Thread):
        def __init__(self, hostname, interface):
                threading.Thread.__init__(self)
                self.hostname = hostname
                self.interface = interface
        def run(self):
                work(self.hostname, self.interface)

def work(hostname, interface):
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
        if (software == 0) or (software == 1): commands = ['term len 0', 'show ip int brie | in ' + interface.split()[0], ] 
        else: commands = ['set cli screen-length 0', 'show interface terse | match ' + interface.split()[0], ]
        temp = []
        for line in commands:
                session.write(line.strip() + '\r')
                time.sleep(2)
                output = session.read_very_eager().split('\n')
                for l in output:
                        if any(n in l for n in dontprint): continue
                        else: 
                                l = host + '\t' + interface + '\t' + l.split()[1]
                                temp.append(l)
        session.write('exit\r')
        session.close()
        report.append(temp)

threads = []
for line in hostnames:
        line = line.strip('\n').split(':')
        router = line[0].split('/')[1]
        interface = line[1]
        thread = login(router, interface)
        threads.append(thread)
        thread.start()
for t in threads:
        t.join()
hostnames.close()
report = sorted(report, key=lambda hostname: hostname[0])
for y in report: 
        for x in y: print x
