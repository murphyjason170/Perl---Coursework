#!/usr/local/bin/perl
use strict;
use warnings;

use Music::Song;

my $pop = Music::Song->new(
	id	=> '12345',
	artist => 'Rick Dees',
	title => 'Disco Duck',
	length => 3 * 60 + 17,
	);

print $pop->title, ' by ', $pop->artist, ' is ', $pop->length_pretty, " seconds long\n";

