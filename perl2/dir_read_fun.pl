#!/usr/bin/perl
use strict;
use warnings;

# 12

my $dir = '..';

opendir my $dh, $dir or die "Couldn't open $dir: $!\n";
while ( my $file_name = readdir $dh )
{
	print "$dir: $file_name\n";
}
closedir $dh;
