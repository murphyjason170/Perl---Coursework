#!/usr/bin/perl
use strict;
use warnings;


my @array = ('alpha', 'beta', 'charlie', 'dune');

# the newer way
foreach ( @array ){
	print $_ . "\n";
}
 
# ancient way!
my $arraySize = @array;
print "The array size is $arraySize\n";
for ( my $index = 0; $index < $arraySize; $index++) {
	print $array[$index] . "\n";
}