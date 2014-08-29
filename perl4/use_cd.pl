#!/usr/local/bin/perl
use strict;
use warnings;

use Music::CD;
use Music::Song;

my $pop = Music::Song->new(
	id => 		12345,
	artist =>	'Rick Dees',
	title =>	'Disco Duck',
	length =>	3*60 + 17,
	);
	
my $scrump = Music::Song->new(
	id =>		54321,
	artist =>	'The Wurzels',
	title =>	'Combine Harvester',
	length =>	3*60 + 5,
	);
	
my $cd = Music::CD->new(
	title =>	'Worst Hits of the Seventies',
	songs =>	[$pop, $scrump]);
	
print 'Total length of songs on "', $cd->title, '" is ', $cd->length_pretty, " \n";


	
			