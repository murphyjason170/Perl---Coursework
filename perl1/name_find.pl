#!/usr/bin/perl
use strict;
use warnings;

my $name = "Charles Francis Xavier";
my @names = split ' ', $name;
my $first_name = shift @names;
my $last_name = pop @names;
print "$name is sanitized to $last_name, $first_name\n";

$name = "Hiram K. Hackenbacker";
@names = split ' ', $name;
$first_name = shift @names;
$last_name = pop @names;
print "$name is sanitized to $last_name, $first_name\n";

$name = "James Mariarty";
@names = split ' ', $name;
$first_name = shift @names;
$last_name = pop @names;
print "%name is sanitized to $last_name, $first_name\n";

$name = "Samuel Finley Breeze Morse";
@names = split ' ', $name;
$first_name = shift @names;
$last_name = pop @names;
print "$name is sanitized to $last_name, $first_name\n";



