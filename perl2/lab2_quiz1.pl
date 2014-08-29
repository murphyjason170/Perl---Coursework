#!/usr/bin/perl
use strict;
use warnings;

my $file = "text_file";
my $line;

# open my $fh, '<', $file || die $! ;
( open my $fh, '<', $file )   or die $!;

while ( $line = <$fh> )
{
	print $line;
}

