#!/usr/bin/perl
use strict;
use warnings;

# Convert liters to various US measurements of volume
my $liters;

my $LITERS_TO_FL_OZ	= 1000 / 29.574;
my $LITERS_TO_PINTS	= 1 / .4731;
my $LITERS_TO_GALLONS	= $LITERS_TO_PINTS / 8;
my $LITERS_TO_CU_IN	= 1000 / 16.387;

print $liters, " liters = ",
	$liters * $LITERS_TO_FL_OZ, 	" fluid ounces, ",
	$liters * $LITERS_TO_PINTS,	" pints, ",
	$liters * $LITERS_TO_GALLONS,	" gallons, ",
	$liters * $LITERS_TO_CU_IN,	" cubic inches\n";
	