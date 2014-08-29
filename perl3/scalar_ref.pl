#!/usr/bin/perl
use strict;
use warnings;

my $marsupial = 'wallaby';

my $creature_ref = \$marsupial;

print $$creature_ref, "\n";
print "\$creature_ref = $creature_ref\n";

my $ref_copy = $creature_ref;
print "\$ref_copy = $ref_copy\n";

my $australian = 'wallaby';
my $aussie_ref = \$australian;

print "\$aussie_ref = $aussie_ref\n";

