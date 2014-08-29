#!/usr/bin/perl
use strict;
use warnings;

while ( <DATA> )
{
	print "Starting to match line: ";
	for my $number (m!(\d+)!g )
	{
		print "- $number";
	}
	print "\n";
}

__END__
Sing a song of 6 pence, a pocket full of rye; 4 and 20 blackbirds, baked in a pie.
1969: Apollo 11 returns from the Moon after travelling 828743 nautical miles.
The first five values of Ackermann's function for n=1 are 2, 3, 5, 13, and 65533.