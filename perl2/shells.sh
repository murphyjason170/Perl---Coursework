#!/bin/sh

# The one-liner 
perl -nle 'm!\w+:\w+:\d+:\d+:.*:.*:(.*)! and $h{$1}++; END{ print "$_:$h{$_}" foreach sort { $h{$b} <=> $h{$a} } keys %h }' /etc/passwd 



# Sample line from /etc/passwd so I can build the regex
# jjanakir:x:30208:10001:Jasumathi Janakiraman:/users/jjanakir/:/bin/bash 

# Reverse the order 
# perl -nle 'm!\w+:\w+:\d+:\d+:.*:.*:(.*)! and $h{$1}++; END{ print "$_:$h{$_}" foreach sort { $h{$a} <=> $h{$b} } keys %h }' /etc/passwd 

# Working simplified example
# perl -nle 'm!(bin)! and $h{$1}++; END{ print "$_: $h{$_}" foreach sort { $h{$b} <=> $h{$a} } keys %h }' /etc/passwd 

 