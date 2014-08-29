#!/usr/bin/perl
use strict;
use warnings;

# This comes in via command line:
my %customer_purchase = @ARGV; 	
# my %customer_purchase = ('White Peaches' => 12, 'Rainier Cherries' => 20, Durien => -1, 'Spartan Apples' => 24 );


# This hash is derived from splitting apart the $lines inventory report:
my %inventory_cost;
my %inventory_quantity;
 
#########This is the $lines to %item_cost hash mapping:
my $lines = <<'END_OF_REPORT';
 0.95   300   White Peaches
 1.45   120   California Avocados
10.50    10   Durien
 0.40  1500   Spartan Apples
 1.50   400   Cherry Tomatoes
END_OF_REPORT


#### Split apart the text inventory and put it in to the two inventory hashes:
foreach my $line ( split "\n", $lines )
{	
	my ($cost, $quantity, $item) = split " ", $line, 3;
	
	# Build the hashes up:
 	$inventory_cost{$item} = $item;
	$inventory_cost{$item} = ($cost);
 	
 	$inventory_quantity{$item} = $item;
 	$inventory_quantity{$item} =  $quantity;
 }


#### Print the inventory table out: 
print "================================\n";
print "The Inventory Table currently is:\n";
print "================================\n";
foreach my $local_item ( sort keys %inventory_cost )
{ 
 		printf ("%5.2f %6d %-15s\n", $inventory_cost{$local_item}, $inventory_quantity{$local_item}, $local_item);
}
print "\n";



##### This is the logic for parsing out the items that the customer purchased
# If customer purchased item is not in inventory then kick out a message indicating so

# Go through each key in the %customer_purchase hash
foreach my $customer_item ( keys %customer_purchase )
{
	# Assess if what the customer puchased is in the inventory hash
	if ( exists $inventory_cost{$customer_item} )
	{
		# print "This item $customer_item is also in inventory\n";
		$inventory_quantity{$customer_item} -= $customer_purchase{$customer_item};	
		
		if ($inventory_quantity{$customer_item} < 1 )
		{
			print "Please restock up on $customer_item because you currently have $inventory_quantity{$customer_item} of these!\n";
		}
	}
 	else
	{
 		warn "*** Sold $customer_purchase{$customer_item} of $customer_item, which were not in inventory\n";
 	}
 	
 	#### Print the inventory table out: 
	print "================================================\n";
	print "The Inventory Table after customer purchases is:\n";
	print "================================================\n";
	foreach my $local_item ( sort keys %inventory_cost )
	{ 
 		printf ("%5.2f %6d %-15s\n", $inventory_cost{$local_item}, $inventory_quantity{$local_item}, $local_item);
	}
	print "\n";

}




