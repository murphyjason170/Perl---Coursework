#!/usr/bin/perl
use strict;
use warnings;

my $date	= localtime();
my $ants	= 47_000;
my $fleas	= 240_000;
my $beetles	= 520;
my $fruit_flies = 1_500_000;

print "\U I am hoping these words are outputted in upper-case!\n";
print "\L I am hoping these words are outputted in lower-case!\n";
print "\ui hope that the first I is upper-case!\n";
print "\lI hope that the first I is lower-case!\n\n";

print << "END_OF_REPORT"; 
Welcome to Echidna Eric's Insect Emporium

This is the inventory stock for $date
---------------------------------------------
We have $ants ants
We have $fleas fleas
We have $beetles beetles
We have $fruit_flies fruit flies
END_OF_REPORT
my $insect_of_the_month = "caterpillar";
my $insect_of_the_month_count = 1_200;
print "This month, we have $insect_of_the_month_count ${insect_of_the_month}s\n";




