#!/usr/bin/perl
use strict;
use warnings;

my $GALLONS_TO_LITERS 	= 3.87;
my $POUNDS_TO_KG	= 0.45;

my $quantity = 0.4;
my $liters = make_metric( $quantity, "gallons" );
print "$quantity gallons = $liters liters\n";

my $kg = make_metric( $quantity, "pounds" );
print "$quantity lbs = $kg kg\n";

sub make_metric
{
	my ( $quantity, $type) = @_;
	
	if ( $type eq 'gallons' )
	{
		return $quantity * $GALLONS_TO_LITERS;
	}
	elsif ( $type eq 'pounds' )
	{
		return $quantity * $POUNDS_TO_KG;
	}
	else
	{
		die "I don't know what to dowith $type\n";
	}
}		