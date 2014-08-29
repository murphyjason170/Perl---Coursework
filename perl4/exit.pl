#!/usr/local/bin/perl
use strict;
use warnings;

# print "Exit is: ", exit;
jason();
# print "Exit code is: ", $?, "\n";



sub jason
{
	print "Good morning Jason!\n";
	print "Exit code is: ", $?, "\n";
	return 7;
}