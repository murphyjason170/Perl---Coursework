#!/usr/bin/perl
use strict;
use warnings;

my @DATA = <DATA>;

my $insect_ref = get_stock_ref('INSECTS');
print "I have ", $insect_ref->('ants'), " ants\n";


my $fish_ref = get_stock_ref('FISH');
print "I have ", $fish_ref->('guppies'), " guppies\n";

print "When looking under insects:\n";
$insect_ref->('guppies');


sub get_stock_ref
{
	print "At sub get_stock_ref\n";
	
	my $seeking = shift;
	print "I am seeking: $seeking\n";
		
	return sub {
		print "\$seeking is $seeking\n";
		my $want = shift;
		my $type;
		for ( @DATA )
		{
			if ((my ($what, $number) = /(.*)\s+(\d+)/) && ($type eq $seeking))
			{
				return $number if $what eq $want;
			}
			elsif ( /(\S+)/ )
			{
				$type = $1;
			}
			else
			{
				next;
			}
		}
		die "Couldn't find any $want\n";
	};
}

__END__

INSECTS
ants 1000000
beetles 200000

MAMMALS
aardvarks 4
antelopes 3

FISH
guppies 10
angel fish 40
king crabs 10


