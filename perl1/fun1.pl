#!/usr/bin/perl
use strict;
use warnings;

my $x = 200.234;

if ( ! $x )
{
	print "x is undefined\n";
}
else
{
	print "x is defined as is: ", $x;
}
