#!/usr/bin/perl
use strict;
use warnings;

my $line1 = "123456789-987654321";
my $line2 = "94560-412342";
my $line3 = "194501";

if ( $line2 =~ m!\b\d{5}-\d{4}\b|\b\d{5}\b! ) {
	print "Matches!\n";
}	

 