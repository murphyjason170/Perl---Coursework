#!/usr/bin/perl
use strict;
use warnings;

# the % sign is the declaration of the hash
my (%count, %cost);	

# 'ants' is the key 
$count{'ants'}		= 47_000;
$count{'fleas'}		= 240_000;
$count{'beetles'}	= 520;
$count{'fruit flies'} 	= 1_500_000;

$cost{'ants'}		= 0.10;
$cost{'fleas'}		= 0.04;
$cost{'beetles'}	= 0.02;
$cost{'fruit flies'}	= 0.001;

foreach my $insect ( keys %count )
{
print "Value of $count{$insect} of $insect on hand at \$$cost{$insect} each\n";
}

print ( exists $cost{spider} );

 