#!/usr/bin/perl
use strict;
use warnings;

my @fruit_types = qw(apple pear kiwi peach lime grape);
print "First fruit type = $fruit_types[0]\n";
my $index = 3;
print "Fruit type at index $index = $fruit_types[$index]\n";
shift @fruit_types;
print "First fruit type is now $fruit_types[0]\n";
print "Last fruit type is $fruit_types[-1]\n";


