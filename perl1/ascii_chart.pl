#!/usr/bin/perl
use strict;
use warnings;

my $INDEX_LOWER = 31;
my $INDEX_UPPER = 126;

while ( $INDEX_LOWER ++ < $INDEX_UPPER ) 
{
	print "$INDEX_LOWER " . chr($INDEX_LOWER) . "\n";
}
