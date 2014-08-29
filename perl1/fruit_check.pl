#!/usr/bin/perl
use strict;
use warnings;

my $fruit;
$fruit = "ORANGE";

my $fruit_lc = lc($fruit);

if ( $fruit_lc eq 'lemon' || $fruit_lc eq 'orange' || $fruit_lc eq 'lime' )
{
	print "Citrus... juicy!\n";
}
elsif ( $fruit_lc eq 'strawberry' || $fruit_lc eq 'raspberry' || $fruit_lc eq 'blackberry' || $fruit_lc eq 'loganberry' )
{
	print "Berry...\n";
	if ( $fruit ne 'loganberry')
	{
		print "pie!\n";
	}
}
else
{
	print "Some other kind of fruit!\n";
}