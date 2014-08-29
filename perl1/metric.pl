#!/usr/bin/perl
use strict;
use warnings;

# Convert meters to feet
my $feet = 5280;	# one mile
my $meters = $feet / 3.2808399;
print $feet, " feet is ", $meters, " meters\n";

