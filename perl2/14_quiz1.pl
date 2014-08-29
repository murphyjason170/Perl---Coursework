#!/usr/bin/perl
use strict;
use warnings;

my $dir = "foo";

opendir my $fh, $dir or die "Couldn't open $dir: $!\n";
while (my $file_name = readdir $fh)
{
	print "$dir: $file_name\n";
}
close $fh;