#!/usr/bin/perl
use strict;
use warnings;

print "who are you";
$name = <STDIN>;
chop $name;

print "$name\n";
print "-" x length ($name),"\n";


