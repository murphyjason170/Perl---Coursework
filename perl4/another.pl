#!/usr/local/bin/perl
use strict;
use warnings;

require 'date_lib.pl';

my $to_subtract = shift || 10_000;

print "$to_subtract seconds ago, the time was ", 
	date_string( time - $to_subtract, '%H:%M:%S'), "\n";
	