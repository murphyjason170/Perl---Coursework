#!/usr/bin/perl
use strict;
use warnings;

use Data::Dumper;

my %state;

$state{AK}{capital} = 'Juneau';
$state{AK}{surf_spot} = 'Tiki Point';
print Dumper \%state;
