#!/usr/local/bin/perl
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);
use DBM::Deep;

tie my %inventory, 'DBM::Deep', { file => 'store.data'};

print "Current inventory:\n";
print "$_: $inventory{$_}\n" for sort keys %inventory;

my ($what, $number);
{
  print "\nEnter a new item and count (e.g. 'Russian Fleas 400'): ";
  chomp ($_ = <STDIN>);
  ($what, $number) = /(.*)\D(\d+)\s*\z/ or redo;
}

$inventory{$what} = $number;
