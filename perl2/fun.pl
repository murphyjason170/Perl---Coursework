#!/usr/bin/perl
use strict;
use warnings;

my $text = "ad";

if ( $text =~ /a[b*c*]d/ )
{
	print "We have a match\n";
}
else
{
	print "No go\n";
}
