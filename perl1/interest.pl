#!/usr/bin/perl
use strict;
use warnings;

# The formula:
# C = P * ( 1 + R/100) ** T
# C = total cost of loan (principal + interest)
# P = Principal
# R = Interest Rate in percent
# T = Term in Years

my $principal = 100000;
my $interest_rate = 7;		# Percent
my $term = 20;			# Years

# Jason's answer here:
my $total_paid = $principal * ( 1 + $interest_rate / 100 ) ** $term;

print "Value of principal + interest after ", $term, " years = ", $total_paid, "\n";
