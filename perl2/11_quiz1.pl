#!/usr/bin/perl
use strict;
use warnings;

my $jason_string = "one, two, three, four... go!";

if ( $jason_string =~ /.*(\w+),/ )
{
	print "We have a match! it is $1 \n";
}