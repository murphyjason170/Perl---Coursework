#!/usr/bin/perl
use strict;
use warnings;

my $lines = <<'END_OF_REPORT';
0.95 	300	White Peaches
1.45	120	California Avocados
5.50	10	Durien
0.40	700	Spartan Apples
END_OF_REPORT

my ($peaches_sold, $avocados_sold, $durien_sold, $apples_sold) = (12, 6, -1, 24);
my ($line1, $line2, $line3, $line4) = split "\n", $lines;
my ($cost, $quantity, $item) = split " ", $line1, 3;
$quantity -= $peaches_sold;
$line1 = join " ", $cost, $quantity, $item;
print "$line1\n";

($cost, $quantity, $item) = split " ", $line2, 3;
$quantity -= $avocados_sold;
$line2 = join " ", $cost, $quantity, $item;
print "$line2\n";

($cost, $quantity, $item) = split " ", $line3, 3;
$quantity -= $durien_sold;
$line3 = join " ", $cost, $quantity, $item;
print "$line3\n";

($cost, $quantity, $item) = split " ", $line4, 3;
$quantity -= $apples_sold;
$line4 = join " ", $cost, $quantity, $item;
print "$line4\n";

