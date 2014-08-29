#!/usr/local/bin/perl
use strict;
use warnings;

my $pid1 = fork;
print $pid1, "\n";
print defined( $pid1 ), "\n";
print "=========================\n";


