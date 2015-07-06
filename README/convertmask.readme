Converts IPs with subnet masks, CIDRs and/or wildcard masks to the preferred format

Usage:		convertmask [OPTION] [filename] | [ip address] [subnet mask] | [ip address/cidr]
Example:	convertmask -c 8.8.8.8 255.255.255.252

Options:
	-h	Prints this help message
	-c	Converts subnet mask or wildcard to cidr notation
	-m	Converts cidr notation or wildcard to subnet mask 
	-m	Converts subnet mask or cidr notation to wildcard
	-f	Allows reading and conversion of file

Example run:

jason@host:~$ cat tmp
10.0.0.0 255.255.255.252
10.0.0.1 255.255.255.252
10.0.0.2 255.255.255.252
10.0.0.3 255.255.255.252
10.0.0.4 255.255.255.252
10.0.0.5 255.255.255.252
10.0.0.6 255.255.255.252
10.0.0.7 255.255.255.252
10.0.0.8 255.255.255.252
10.0.0.9 255.255.255.252
10.0.0.10 255.255.255.252
jason@host:~$ convertmask -fc tmp
10.0.0.0/30  
10.0.0.1/30  
10.0.0.2/30  
10.0.0.3/30  
10.0.0.4/30  
10.0.0.5/30  
10.0.0.6/30  
10.0.0.7/30  
10.0.0.8/30  
10.0.0.9/30  
10.0.0.10/30  

This also works when text is in-line with ip's:

jason@host:~$ cat tmp
ip address 10.0.0.0 255.255.255.252
ip address 10.0.0.1 255.255.255.252
#line with no ip's#
ip address 10.0.0.2 255.255.255.252
ip address 10.0.0.3 255.255.255.252
ip address 10.0.0.4 255.255.255.252
ip address 10.0.0.5 255.255.255.252
ip address 10.0.0.6 255.255.255.252
ip address 10.0.0.7 255.255.255.252
ip address 10.0.0.8 255.255.255.252
ip address 10.0.0.9 255.255.255.252
ip address 10.0.0.10 255.255.255.252
jason@host:~$ convertmask -fc tmp
ip address 10.0.0.0/30  
ip address 10.0.0.1/30  
#line with no ip's#
ip address 10.0.0.2/30  
ip address 10.0.0.3/30  
ip address 10.0.0.4/30  
ip address 10.0.0.5/30  
ip address 10.0.0.6/30  
ip address 10.0.0.7/30  
ip address 10.0.0.8/30  
ip address 10.0.0.9/30  
ip address 10.0.0.10/30
