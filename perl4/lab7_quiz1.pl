#!/usr/local/bin/perl
use strict;
use warnings;

use DB_File;
use Data::Dumper;

tie my %hash, DB_File => "data.store" or die;
print Dumper \%hash;
$hash{key} = 'value';
$hash{level_1}{level_2} = 'inner value';
$hash{tiki} = 'yaki';
print Dumper \%hash;
	