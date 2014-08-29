#!/usr/bin/perl
use strict;
use warnings;

my @parts = localtime();
my $count = 0;
foreach my $part ( @parts )
{
	print "Element $count = $part\n";
	$count++;
}
