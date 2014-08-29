#!/usr/bin/perl
use strict;
use warnings;

my $count = 0;
 
foreach my $argument ( @ARGV )
{
	if ( index ($argument, "-d") != -1 || index ($argument, "Ganymede") )
	{
		print "We have a match! An argument passed from the command line matched\n";
	}
	else
	{
		print "No match found\n";
	} 
}

 