#!/usr/bin/perl
use strict;
use warnings;

my @keys = qw ( tetra hexa octa dodeca icosa );
my @values = (4, 6, 8, 12, 20);

foreach my $key ( @keys )
{
	$key .= 'hedron';
}
my %faces = interleave_words( scalar(@keys), @keys, @values);
foreach my $solid ( keys %faces )
{
	print "A(n) $solid has $faces{$solid} faces\n";
}

 
sub interleave_words
{
	my @results;
	
	my $count = shift;
	
	foreach my $index ( 0 .. $count-1 )
	{
		$results[$index * 2] = shift;
	}
	if ( @_ != $count )
	{
		die "Second array not same size ($count) as the first\n";
	}
	foreach my $index ( 0 .. $count-1 )
	{
		$results[$index * 2 + 1] = shift;
	}
	
	return @results;
}