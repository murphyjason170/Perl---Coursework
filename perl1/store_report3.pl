#!/usr/bin/perl
use strict;
use warnings;

my $lines = <<'END_OF_REPORT';
 0.95   300   White Peaches
 1.45   120   California Avocados
10.50    10   Durien
 0.40  1500   Spartan Apples
 1.50   400   Cherry Tomatoes
END_OF_REPORT

my (%item_cost, %inventory);
foreach my $line ( split "\n", $lines )
{	my ($cost, $quantity, $item) = split " ", $line, 3;
	$item_cost{$item} = $cost;
	$inventory{$item} = $quantity;
}

my %sold = ('White Peaches' => 12, 'Rainier Cherries' => 20, 
	Durien => -1, 'Spartan Apples' => 24 );
	
foreach my $item ( keys %sold )
{
	if ( exists $inventory{$item} )
	{
		$inventory{$item} -= $sold{$item};
	}
	else
	{
		warn "*** Sold $sold{$item} of $item, which were not in inventory\n";
	}
}

foreach my $item ( sort keys %item_cost )
{
	printf "%5.2f %6d %s\n", $item_cost{$item}, $inventory{$item}, $item;
}

