#!/usr/bin/perl
use strict;
use warnings;

my $cash = 600000;

my $principal = 100000;
my $interest_rate = 7;  
my $term = 20;
my $total_paid = $principal * (1 + $interest_rate/100) ** $term;

# Cash
print "The cash is: ", $cash;
print "\n";

# This is purely for info output
print "The total paid is: ", $total_paid;
print "\n";


# if $cash is more than 10% larger than the value of $total_paid print "approved"
if ( $cash > ($total_paid * 1.10) )
{
	print "Approved\n";
}

# if $cash is less than $total_paid print "unacceptable"
elsif ( $cash < $total_paid )
{
	print "Unacceptable\n";
} 


# if $cash is between 0% and 10% larger than $total_paid print "marginal"
elsif ( $cash >= $total_paid || $cash < $total_paid*1.10 )
{
	print "Marginal\n";
}

# Come up with a case that catches out of bounds
else
{
	print "We are in else-land!";
}




 