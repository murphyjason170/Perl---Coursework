#!/usr/bin/perl
use strict;
use warnings;

my $temp = $<;
my @info = getpwuid($temp);

print "@info\n";
