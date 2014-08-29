#!/usr/bin/perl
use strict;
use warnings;

opendir my $dh, "/" or die "Can't opendir /: $!\n";
print "$_\n" while readdir $dh;

