#!/usr/bin/perl
use strict;
use warnings;

my $radius;
$radius = 49.4;
my $PI = 3.14159265;
my $volume = 4/3 * $PI * ($radius ** 3);
print "Volume of sphere of radius ", $radius, " = ", $volume, "\n";

