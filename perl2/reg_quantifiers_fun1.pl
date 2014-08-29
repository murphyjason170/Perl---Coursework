#!/usr/bin/perl
use strict;
use warnings;

while ( defined ( my $line = <DATA> ) )
{
	chomp $line;
	print "'$line' contains a zip code\n"
		if $line =~ /[A-Z]+\d*/;		
}

__END__
A
Z1
A1B2
A1B2C3D4E5F6
AZ5AAAAA1
11111
AAAAA
