#!/usr/bin/perl
use strict;
use warnings;

for ( prompt() ; <STDIN>; prompt() )
{
	print "Input receieved: ";
	print;
	last if /Quit/i;
}

sub prompt { print "Input: "}