#!/usr/bin/perl
use strict;
use warnings;

my @instructions = qw ( PUSH POP UNSHIFT QUIT NOTREACHED );
my @extra = qw ( POP PUSH );

while ( my $instruction = shift @instructions )
{
	if ( $instruction eq 'QUIT' )
	{
		print "Quitting\n";
		last;
	}
	print "Executing $instruction\n";
	if ( $instruction eq 'POP' )
	{
		pop @instructions;
	}
	elsif ( $instruction eq 'SHIFT' )
	{
		shift @instructions;
	}
	elsif ( $instruction eq 'PUSH' )
	{
		push @instructions, shift @extra;
	}
	elsif ( $instruction eq 'UNSHIFT' )
	{
		unshift @instructions, shift @extra;
	}
}