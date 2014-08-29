#!/usr/bin/perl
use strict;
use warnings;

my $PI = 3.14159265;
my $radius = 71.5;

{
my $area = $PI * $radius ** 2;
print "Area of circle of radius $radius is $area\n";
}

my $volume = 4/3 * $PI * $radius ** 3;
print "Volume of sphere of radius $radius is $volume\n";
my $height = 21;
$volume = $PI * $radius ** 2 * $height;
print "Volume of cylinder of radius $radius and height $height is $volume\n";


