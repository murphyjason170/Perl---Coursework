#!/usr/bin/perl
use strict;
use warnings;

my (%item_cost, %inventory);

my $line_counter = 0;	

while ( defined ( my $line = <> ) )
{
	chomp $line;

	if ( $line eq "Price,Quantity,Name" )
	{
 		next;
	}

	$line_counter++;
	
	my ($cost, $quantity, $item ) = split ",", $line, 3;
	$item_cost{$item} = $cost;
	$inventory{$item} = $quantity;

	if ($quantity < 0 )
	{
		warn "Inventory item $item is negative at line $line_counter. Please stock up!\n\n";
	}
}

my %sold = ('White Peaches' => 12, 'Rainier Cherries' => 20, Durien => -1, 'Spartan Apples' => 24 );

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
