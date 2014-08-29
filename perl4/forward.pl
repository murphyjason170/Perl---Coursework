#!/usr/local/bin/perl
use strict;
use warnings;

use MyCode::DateLib; 
my $today = date_string time, '%d-%b-%y';
print "$today\n";