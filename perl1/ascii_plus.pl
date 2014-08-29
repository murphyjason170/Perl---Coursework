#!/usr/bin/perl
use strict;
use warnings;

foreach my $INDEX_LOWER ( 32 .. 126 )
{
	printf "%3d %2x %4o %8b %1s\n", $INDEX_LOWER, $INDEX_LOWER, $INDEX_LOWER, $INDEX_LOWER, chr($INDEX_LOWER);	
}
