#!/usr/bin/perl
use strict;

my @array;

# Accurate way of slicing
$array[0] = localtime;
print "\$array[0] = $array[0]\n";

# Inaccurate way of slicing
@array[0] localtime;
print "\$array[0] = $array[0]\n";

