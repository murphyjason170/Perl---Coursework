#!/usr/local/bin/perl
use strict;
use warnings;

use MyCase;

tie my %phone, 'MyCase';

$phone{'Bob DeLong'} = '555-1234';
$phone{'BOB DELONG'} = '555-4321';

print $phone{'bob delong'}, "\n";
print keys ( %phone ), "\n";

