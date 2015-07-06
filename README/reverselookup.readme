Usage:          reverselookup [OPTION] [filename] | [start ip address] [end ip address]
Example:        reverselookup -c ipaddresses.txt

Input file should include one ip address per line

Options:
	-h	Prints this menu
        -c      Prints IPs regardless of whether DNS entry exists
        -n      Like -c, except prints "No DNS Entry Found" in the hostname column
        -r      Prints Hostnames in first column, IPs in second
        -H      Prints Hostnames only
        -i      Allows use of start and end IP addresses for range lookups

Example output:

[jason@host~]$ reverselookup test
24.175.48.109   lo0.dllbtxlb12r.texas.rr.com
24.175.48.110   lo0.dllbtxlb13r.texas.rr.com
24.175.48.115   lo0.wylitx3101v.texas.rr.com
24.175.48.118   lo0.dllbtxlb14r.texas.rr.com
24.175.48.120   lo0.artotxpz01v.texas.rr.com
24.175.48.121   lo0.irngtx3101v.texas.rr.com
24.175.48.122   lo0.irnhtxof01v.texas.rr.com
24.175.48.123   lo0.crtntxjt01v.texas.rr.com
24.175.48.124   lo0.artntxaf01v.texas.rr.com
24.175.48.125   lo0.wcfltxjj09v.texas.rr.com
24.175.48.126   lo0.grpvtx1101v.texas.rr.com
24.175.48.127   lo0.lncstx9901v.texas.rr.com
24.175.48.128   lo0.dllxtx4901v.texas.rr.com

[jason@host ~]$ reverselookup -i 24.175.44.0 24.175.44.10
24.175.44.1     lo0.dllbtxlb06r.texas.rr.com
24.175.44.2     lo0.dllbtxlb07r.texas.rr.com
24.175.44.3     lo0.dllbtxlb08r.texas.rr.com
24.175.44.4     lo0.dllbtxlb09r.texas.rr.com
24.175.44.5     lo0.dllbtxlb01v.texas.rr.com
24.175.44.6     lo0.dllbtxlb02v.texas.rr.com
24.175.44.7     lo0.dllbtxlb03v.texas.rr.com
24.175.44.8     lo0.dllbtxlb04v.texas.rr.com
24.175.44.9     lo0.dllbtxlb05v.texas.rr.com
24.175.44.10    lo0.dllbtxlb06v.texas.rr.com

[jason@host ~]$ reverselookup -n test
24.175.48.109   lo0.dllbtxlb12r.texas.rr.com
24.175.48.110   lo0.dllbtxlb13r.texas.rr.com
24.175.48.111   No DNS Entry Found
24.175.48.112   No DNS Entry Found
24.175.48.113   No DNS Entry Found
24.175.48.114   No DNS Entry Found
24.175.48.115   lo0.wylitx3101v.texas.rr.com
24.175.48.116   No DNS Entry Found
24.175.48.117   No DNS Entry Found
24.175.48.118   lo0.dllbtxlb14r.texas.rr.com
24.175.48.119   No DNS Entry Found
24.175.48.120   lo0.artotxpz01v.texas.rr.com
24.175.48.121   lo0.irngtx3101v.texas.rr.com
24.175.48.122   lo0.irnhtxof01v.texas.rr.com
24.175.48.123   lo0.crtntxjt01v.texas.rr.com
24.175.48.124   lo0.artntxaf01v.texas.rr.com
24.175.48.125   lo0.wcfltxjj09v.texas.rr.com
24.175.48.126   lo0.grpvtx1101v.texas.rr.com
24.175.48.127   lo0.lncstx9901v.texas.rr.com
24.175.48.128   lo0.dllxtx4901v.texas.rr.com
24.175.48.129   No DNS Entry Found
24.175.48.130   No DNS Entry Found

[jason@host ~]$ reverselookup -c test
24.175.48.109   lo0.dllbtxlb12r.texas.rr.com
24.175.48.110   lo0.dllbtxlb13r.texas.rr.com
24.175.48.111
24.175.48.112
24.175.48.113
24.175.48.114
24.175.48.115   lo0.wylitx3101v.texas.rr.com
24.175.48.116
24.175.48.117
24.175.48.118   lo0.dllbtxlb14r.texas.rr.com
24.175.48.119
24.175.48.120   lo0.artotxpz01v.texas.rr.com
24.175.48.121   lo0.irngtx3101v.texas.rr.com
24.175.48.122   lo0.irnhtxof01v.texas.rr.com
24.175.48.123   lo0.crtntxjt01v.texas.rr.com
24.175.48.124   lo0.artntxaf01v.texas.rr.com
24.175.48.125   lo0.wcfltxjj09v.texas.rr.com
24.175.48.126   lo0.grpvtx1101v.texas.rr.com
24.175.48.127   lo0.lncstx9901v.texas.rr.com
24.175.48.128   lo0.dllxtx4901v.texas.rr.com
24.175.48.129
24.175.48.130


[jason@host ~]$ reverselookup -r test
lo0.dllbtxlb12r.texas.rr.com     24.175.48.109
lo0.dllbtxlb13r.texas.rr.com     24.175.48.110
lo0.wylitx3101v.texas.rr.com     24.175.48.115
lo0.dllbtxlb14r.texas.rr.com     24.175.48.118
lo0.artotxpz01v.texas.rr.com     24.175.48.120
lo0.irngtx3101v.texas.rr.com     24.175.48.121
lo0.irnhtxof01v.texas.rr.com     24.175.48.122
lo0.crtntxjt01v.texas.rr.com     24.175.48.123
lo0.artntxaf01v.texas.rr.com     24.175.48.124
lo0.wcfltxjj09v.texas.rr.com     24.175.48.125
lo0.grpvtx1101v.texas.rr.com     24.175.48.126
lo0.lncstx9901v.texas.rr.com     24.175.48.127
lo0.dllxtx4901v.texas.rr.com     24.175.48.128

[jason@host ~]$ reverselookup -H test
lo0.dllbtxlb12r.texas.rr.com
lo0.dllbtxlb13r.texas.rr.com
lo0.wylitx3101v.texas.rr.com
lo0.dllbtxlb14r.texas.rr.com
lo0.artotxpz01v.texas.rr.com
lo0.irngtx3101v.texas.rr.com
lo0.irnhtxof01v.texas.rr.com
lo0.crtntxjt01v.texas.rr.com
lo0.artntxaf01v.texas.rr.com
lo0.wcfltxjj09v.texas.rr.com
lo0.grpvtx1101v.texas.rr.com
lo0.lncstx9901v.texas.rr.com
lo0.dllxtx4901v.texas.rr.com
