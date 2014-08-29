#!/usr/local/bin/perl
use strict;
use warnings;
use MyTime;

tie my $now, "MyTime", '%M min %S sec';

$now = "hoodoogurus";

print "The time is now $now\n";
sleep 5;
print "The time is now $now\n";
