#!/usr/bin/perl
use strict;
use warnings;

my $dir = '/etc';
opendir my $dh, $dir or die "COuldn't open $dir: $!\n";

for my $file_name(readdir $dh)
{
    print "$dir: $file_name\n";
}

closedir $dh;

