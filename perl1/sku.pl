#!/usr/bin/perl
use strict;
use warnings;

my $stock_lines = <<'END_OF_REPORT';
Inventory Stock-Keeping Units follow:
90-5825 87-9398 93-8589 40-6910
END_OF_REPORT

my ($heading, $line1) = split "\n", $stock_lines;
my @SKUs = split " ", $line1;
my ($sku1, $sku2, $sku3, $sku4) = @SKUs;
print "First SKU = $sku1; third SKU = $sku3\n";
print "All SKUs: @SKUs\n";
