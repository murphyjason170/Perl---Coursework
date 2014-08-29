#!/usr/local/bin/perl
use strict;
use warnings;

push @INC, "../tmp";
require 'date_lib.pl';

while (<DATA>)
{
	chomp;
	my ($epoch, $event) = split /\s+/, $_, 2;
	print date_string($epoch, '%d-%b-%y'), " $event\n";
}

__END__
1310070000 Birthday party
1324825260 Open Xmas presents
1309822200 Barbecue potluck
1302714600 Return library book