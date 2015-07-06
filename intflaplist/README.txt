Shows which and how many times interfaces flapped on a given device today.
Input time in format HH (to check all flaps in an hour) or HH:M (to match all flaps in a 10 minute period) or HH:MM (to match all flaps in a minute) if desired.
Works with IOS-XR only at this time.

Cut/paste the script into a file using your text editor of choice into your directory of choice.
Run the script using python, or use "chmod +x" to make the script executable.

Any questions/comments may be submitted to jason.shaffner@twcable.com

Sample run:

[jason@host~]$ python intflaplist.py
Username: jason
Password: 
Device: phrrtxgy01r
Time (24 hour clock):


FLAPS  INTERFACE          ADMIN       OPER        DESCRIPTION
--------------------------------------------------------------------------------------
    5  Te0/7/0/3          up          up          tge to hrlntxcb01r tge 0/7/0/3 BE10
    1  Te0/8/0/1          up          up          tge to phrrtxgy-ons2 XP2/12/1 -> rgcytxay-ons1 1/16/1 -> rgcytxay01h te9/1  
    2  Te0/9/0/1          up          up          tge to phrrtxgy01h tge9/2
    1  Te0/9/0/13         up          up          tge to phrrtxgy-ons2 2/17/1 -> lnvstx01-ons1 1/17/1 -> lnvstx0101h te9/2



Sample run using optional time feature:

[jason@host~]$ python intflaplist.py
Username: jason
Password: 
Device: ausxtxir02r
Time (24 hour clock): 13:2


FLAPS  INTERFACE          ADMIN       OPER        DESCRIPTION
--------------------------------------------------------------------------------------
 1201  Te0/10/0/10        up          up          tge to lckhtx0202h tge0/0/95
