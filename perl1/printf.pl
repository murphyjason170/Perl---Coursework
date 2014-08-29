#!/usr/bin/perl
use strict;
use warnings;

printf "I'm an ordinary string.\n";
printf "Here's a number in a field of 10 characters: <%10d>\n", 42;
printf "Here's a date: %02d/%02d/%4d\n", 7, 4, 1776;
my $PI = 3.14159265358979;
printf "PI to 3 decimal places = %.3f\n", $PI;
printf "PI to 4 decimal places = %.4f\n", $PI;
my $places = 5;
printf "PI to $places = %.*f\n", $places, $PI;
my $integer = 161;
printf "$integer in octal	= %o\n", $integer;
printf "$integer in hexadecimal = %n\n", $integer;
printf "$integer in binary	= %b\n", $integer;
printf "%10s-justified string; %-10s-justified string\n", qw<right left>;

