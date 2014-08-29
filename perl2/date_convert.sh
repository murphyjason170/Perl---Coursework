#!/bin/sh
cat some_dates.txt
perl -pi.bak -e 's/(\d+)\/(\d+)\/(\d+)/$3-$1-$2/' ./some_dates.txt
 
# $1 = month
# $2 = day
# $3 = year

 