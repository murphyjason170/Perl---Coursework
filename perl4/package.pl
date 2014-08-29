#!/usr/local/bin/perl
use strict;
use warnings;

$main::global = "This is a saved global variable";


{
	our $package = "This is a package variable";
	my_sub();
	print "After my_sub(), \$package = $package\n";
	print "And \$main::global = $main::global\n";
}

print "Outside block, \$main::global = $main::global\n";

sub my_sub
{
	our $package;
	print "\$package = $package\n";
	local $package = "Oops";
	$main::global = "See how package variables are global?";	
}

