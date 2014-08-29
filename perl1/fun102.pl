#!/usr/bin/perl
use strict;
use warnings;

my $rev = scalar reverse "amanaP--lanac a ,nalp a ,nam A";
print $rev . "\n\n";

# This is the algorithm that we need to compress into 1 line
# @prices = reverse(@prices);
# my $priciest = shift @prices;  
 
my @prices = ( 1, 2, 3, 4, 5 );
my $priciest = @prices = reverse(@prices), shift @prices  ;  
print $priciest;
 
print "\n";
 