#!/usr/bin/perl
use strict;
use warnings;

my $zip = 0xface0ff;

if ( length ($zip) == 5 )
{
	print "$zip could be a standard zip code\n";
}
elsif ( length ( $zip ) == 9 || length ( $zip ) == 10 )
{
	print "$zip could be a ZIP+4 code \n";
}
else
{
	die "$zip is not a zip code\n";
}
