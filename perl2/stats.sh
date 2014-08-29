#!/bin/sh

# Format example of netstat output
# tcp 0 0 cold.useractive.com:230 tap.oreillyschool.com:47440 TIME_WAIT
# tcp 0 0 cold.local.use:zabbix-agent mon.local.useractive.:57237 TIME_WAIT
# tcp 0 0 cold.local.use:zabbix-agent mon.local.useractive.:57098 TIME_WAIT

# This is the one-liner:
netstat | perl -ne 'print "$. \t $1\n"  if m!\w+\s+\d\s+\d\s+.*\s+(.*):! && (3..12)'

# babystep 3 - using literals that will need to be generalized to match
# netstat | perl -ne 'print "$1\n"  if m!tcp\s+0\s+0\s+.*\s+(.*):! && (3..12)'

# babystep 2 - match on something easy and also the line numbers
# netstat | perl -ne 'print if m!tcp! && (3..12)'

# babystep 1 - just match on something easy
# netstat | perl -ne 'print if m!cold\.useractive!'


 


 
 

