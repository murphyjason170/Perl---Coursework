#!/usr/bin/perl
use strict;
use warnings;

my %area_ref = ( 3 => \&triangle, 4=> \&square, 5=> \&pentagon);

my $side = shift or die;	# Length;

for my $sides (3..5)
{
	print "Area of regular $sides-gon of side $side = ",
	$area_ref{$sides}->($side), "\n";
}


sub triangle
{
	my $side = shift;
	return sqrt(3)/4 * $side ** 2;
}

sub square
{
	my $side = shift;
	return $side ** 2;
}

sub pentagon
{
	my $side = shift;
	return sqrt(25 + 10 * sqrt(5)) / 4 * $side ** 2;
}

