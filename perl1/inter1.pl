#!/usr/bin/perl
# 12
use strict;
use warnings;
 	
my @first = qw(Can unlock secret);
my @second = qw(you the code?);

my @mixed = interleave_words( scalar(@first), @first, @second);
print "Result: @mixed\n";

sub interleave_words
{
	my @results;
	
	my $count = shift;
	print "Count is currently $count\n";
	
	foreach my $index (0 .. $count-1 )
	{
		print "Count is currently $count\n";
		$results[$index * 2] = shift;
	}
	foreach my $index (0 .. $count-1 )
	{
		print "Count is currently $count\n";
		$results[$index * 2 + 1] = shift;
	}
	return @results;
}
 