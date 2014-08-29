#!/usr/bin/perl
use strict;
use warnings;

# To run this:
# ./state_fun1.pl /software/Perl3/state_full.data

my %state;
my @names;

while (<>)
{
	chomp;
	my ($abbreviation, @fields) = split /\s*\|\s*/;
	@names = @fields and next if $abbreviation eq 'key';
	
	$state{$abbreviation} = \@fields;	
}

print "Debug stuff:\n";
print "@{$state{'HI'}} \n";

my $limit;
for my $abbr (sort keys %state)
{
	print "$abbr:\n";
	
	my @values = @{ $state{$abbr} };
	
	for my $key ( @names )
	{
		print "\t$key: ", shift @values, "\n";
	}
	print "\n";
	exit if ++$limit >= 5;
}