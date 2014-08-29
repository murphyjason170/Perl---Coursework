#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my %marsupial = map { ($_, 1) } qw(koala kangaroo possum wombat);

chomp (my @amphibians = <DATA>);

my %amphibian = map { ($_, 1) } @amphibians;

# print "Marsupials: ", join(' ', sort keys %marsupial), "\n";
# print "Amphibians: ", join(' ', sort keys %amphibian), "\n";
print Dumper \%amphibian, \%marsupial;

__END__
frog
toad
salamander
newt
caecilian
