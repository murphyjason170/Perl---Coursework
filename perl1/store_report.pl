#!/usr/bin/perl
use strict;
use warnings;

# Great start! However, notice you have very brittle code: 
# if ($hash_item ne 'White Peaches' && $hash_item && 'California Avocados' && $hash_item ne 'Durien' && $hash_item ne 'Spartan Apples' ) 
# It's brittle because it is using a priori knowledge to state whether something is or is not in the inventory. There's a better way. Create another hash, perhaps called %inventory, to keep track of what is in the inventory and what isn't. Then check the keys in the %sold hash to see if a key exists in the %inventory hash. Hope that helps! 

my $lines = <<'END_OF_REPORT';
	0.95	300	White Peaches
	1.45	120	California Avocados
	0.40	1500	Spartan Apples
	10.50	 10	Durien
END_OF_REPORT

my %sold = ('White Peaches' => 12, 'Rainier Cherries' => 20, 
		'Durien' => -1, 'Spartan Apples' => 24, 'Oranges' => 15, 'Plums' => 16, 'Bananas' => 17, 'Pineapples' => 18, 'Fuji Apples' => 19);

my @items_array;
my $index = 0;
 		
foreach my $line ( split "\n", $lines )
{
	my ($cost, $quantity, $item) = split " ", $line, 3;
	if ( exists $sold{$item} )
	{
		$quantity -= $sold{$item};
	}
	else
	{
		warn "Didn't sell any $item this time\n";
	}
	printf "%5.2f %6d %s\n", $cost, $quantity, $item;
}
print "\n";


# Here I am doing a two-step to get the $lines into the %inventory hash.
# Step 1: Dump the $lines into an @items_array 
foreach my $line_1 ( split "\n", $lines )
{
	my ($cost_1, $quantity_1, $item_1) = split " ", $line_1, 3;
	
	$items_array[ $index ] = $item_1;
	$index++;		 
}

 
# Step 2: Dumping the @items_array into the %inventory hash
my %inventory;

foreach my $individual_item (@items_array)
{
	# print "Initializing with $individual_item\n";
 	$inventory{ $individual_item } = 0.10;
}



# This is the logic for assessing if the key exists both in the %sold and the %inventory hash:
foreach my $hash_item ( keys %sold )
{
	if ( exists $inventory{$hash_item} )
	{
		# This output is not a requirement but I did it for testing purposes
		# print "$hash_item exists both in the inventory hash and the sold hash\n";
	}
	else
	{
		print "*** Sold $sold{$hash_item} of ", $hash_item, " which were not in inventory\n";
	}	
}




