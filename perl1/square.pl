#!/usr/local/bin/perl
use strict;
use warnings;

my $x = 0;
while ( $x++ < 10 )
{
 	print "$x squared = ", $x**2, "; ";
	print "Square root of $x = ", $x**0.5, "\n";
}

